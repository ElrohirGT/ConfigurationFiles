{pkgs, ...}: {
  # Enabling/Disabling formatting according to keybinds
  keymaps = [
    {
      action = ":FormatDisable<CR>";
      key = "<leader>df";
      mode = "n";
      options = {
        desc = "[D]isable [F]ormatting for current buffer";
      };
    }
    {
      action = ":FormatEnable<CR>";
      key = "<leader>fe";
      mode = "n";
      options = {
        desc = "[F]ormatting [E]nable";
      };
    }
  ];

  userCommands = {
    FormatEnable = {
      desc = "Enable autoformating";
      command = {
        __raw = ''
          function()
          	vim.b.disable_autoformat = false
          end
        '';
      };
    };

    FormatDisable = {
      desc = "Disable autoformating";
      command = {
        __raw = ''
          function(args)
            vim.b.disable_autoformat = true
          end
        '';
      };
    };
  };

  autoCmd = let
    genCmd = patterns: command: {
      event = ["BufWritePost"];
      pattern = patterns;
      callback = {
        __raw = ''
          function(args)
          	if not vim.b.disable_autoformat then
          		vim.cmd("${command}")
          	end
          end
        '';
      };
    };
  in [
    # Nix language
    (genCmd
      ["*.nix"]
      "!${pkgs.alejandra}/bin/alejandra %")

    # Javascript and Typescript
    (genCmd
      ["*.js" "*.ts"]
      "!${pkgs.biome}/bin/biome format --write %")

    # Bash files
    (genCmd
      ["*.sh"]
      "!${pkgs.shfmt}/bin/shfmt --write %")

    # SQL files
    (genCmd
      ["*.sql"]
      "!${pkgs.sqlfluff}/bin/sqlfluff format --dialect postgres %")

    # Python files
    (genCmd
      ["*.py"]
      "!${pkgs.black}/bin/black %")

    # Markdown files
    (genCmd ["*.md"] "!${pkgs.mdformat}/bin/mdformat %")

    # Zig files
    (genCmd ["*.zig"] "!${pkgs.zig}/bin/zig fmt %")

    # Go files
    (genCmd ["*.go"] "!${pkgs.go}/bin/go fmt %")

    # Elm files
    (genCmd ["*.elm"] "!${pkgs.elmPackages.elm-format}/bin/elm-format --yes %")
  ];
}
