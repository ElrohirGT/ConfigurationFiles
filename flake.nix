{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
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
    self,
    nixpkgs,
    nixpkgs_unstable,
    nixVim,
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
      ] (system:
        function {
          pkgs = import pkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              #inputs.something.overlays.default
            ];
          };
          system = system;
        });
    buildVimModule = {
      system,
      module,
    }: let
      nixvimPkgs = nixVim.legacyPackages.${system};
      nixVimModule = {
        module = import "${module}";
      };
    in
      nixvimPkgs.makeNixvimWithModule nixVimModule;
  in {
    nixosConfigurations.foxatop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./hosts/default/configuration.nix
      ];
    };

    packages = forAllSystems {
      pkgs = nixpkgs_unstable;
      function = {
        pkgs,
        system,
      }: {
        vim = buildVimModule {
          system = system;
          module = ./modules/nixvim;
        };
        vimMinimal = buildVimModule {
          system = system;
          module = ./modules/nixvim/minimal.nix;
        };
      };
    };

    checks = forAllSystems {
      pkgs = nixpkgs_unstable;
      function = {
        pkgs,
        system,
      }: let
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
  };
}
