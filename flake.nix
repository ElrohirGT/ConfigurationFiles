{
  description = "ElrohirGT's NixOS configuration";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Nix formatting pack
    # https://gerschtli.github.io/nix-formatter-pack/nix-formatter-pack-options.html
    nix-formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs_unstable";
    };
    nixVim = {
      # I prefer to have nixvim run on unstable instead
      # to get acces to more plugins
      url = "github:nix-community/nixvim";
      # url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs_unstable";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs_unstable,
    nixVim,
    nix-formatter-pack,
    ...
  } @ inputs: let
    forAllSystems = {
      pkgs ? nixpkgs,
      function,
    }:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-macos"
        "aarch64-linux"
        "aarch64-darwin"
      ]
      (system:
        function {
          pkgs = pkgs.legacyPackages.${system};
          inherit system;
        });

    buildVimModule = {
      system,
      module,
    }: let
      nixvimPkgs = nixVim.legacyPackages.${system};
      nixVimModule = {
        inherit module;
      };
    in
      nixvimPkgs.makeNixvimWithModule nixVimModule;
  in {
    nixosConfigurations.elrohirgt = let
      system = "x86_64-linux";
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs_unstable = import nixpkgs_unstable {
            localSystem = system;
            config = {
              allowUnfree = true;
            };
          };
        };
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./hosts/default/configuration.nix
        ];
      };

    formatter = forAllSystems {
      pkgs = nixpkgs_unstable;
      function = {pkgs, ...}:
        nix-formatter-pack.lib.mkFormatter {
          inherit pkgs;

          config.tools = {
            deadnix.enable = true;
            alejandra.enable = true;
            statix.enable = true;
          };
        };
    };

    packages = forAllSystems {
      pkgs = nixpkgs_unstable;
      function = {system, ...}: {
        vim = buildVimModule {
          inherit system;
          module = ./modules/nixvim;
        };
        vimMinimal = buildVimModule {
          inherit system;
          module = ./modules/nixvim/minimal.nix;
        };
        vimTribal = buildVimModule {
          inherit system;
          module = ./modules/nixvim/tribal.nix;
        };
      };
    };

    checks = forAllSystems {
      pkgs = nixpkgs_unstable;
      function = {system, ...}: let
        nixvimLib = nixVim.lib.${system};

        nixVimModuleFull = {
          module = import ./modules/nixvim;
        };
        nixVimModuleMinimal = {
          module = import ./modules/nixvim/minimal.nix;
        };
      in {
        # Run `nix flake check .` to verify that your nixvim config is not broken
        default = nixvimLib.check.mkTestDerivationFromNixvimModule nixVimModuleFull;
        minimal = nixvimLib.check.mkTestDerivationFromNixvimModule nixVimModuleMinimal;
      };
    };

    templates.default = {
      path = ./modules/templates/basic;
      description = "A very basic multiplatform nix template!";
    };
  };
}
