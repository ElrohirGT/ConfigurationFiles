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
      "!alejandra '%'")

    # Javascript and Typescript
    (genCmd
      ["*.js" "*.ts"]
      "!biome format --write '%'")

    # Bash files
    (genCmd
      ["*.sh"]
      "!${pkgs.shfmt}/bin/shfmt --write '%'")

    # SQL files
    (genCmd
      ["*.sql"]
      "!${pkgs.sqlfluff}/bin/sqlfluff format --dialect postgres '%'")

    # Python files
    (genCmd
      ["*.py"]
      "!black '%'")

    # Markdown files
    (genCmd ["*.md"] "!${pkgs.mdformat.withPlugins (p: with p; [mdformat-myst])}/bin/mdformat --wrap 80 '%'")

    # Zig files
    (genCmd ["*.zig"] "!zig fmt '%'")

    # C files
    (genCmd ["*.c"] "!clang-format -i '%'")

    # Go files
    (genCmd ["*.go"] "!gofmt -w '%'")

    # Gleam files
    (genCmd ["*.gleam"] "!gleam format '%'")

    # Elm files
    (genCmd ["*.elm"] "!elm-format --yes '%'")

    # Nim files
    # It cannot convert tabs to spaces
    # (genCmd ["*.nim"] "!nph '%'")
  ];
}
