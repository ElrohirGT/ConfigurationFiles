{
  pkgs,
  lib,
  ...
}: {
  # Enabling/Disabling formatting according to keybinds
  keymaps = [
    {
      action = ":FormatDisable!<CR>";
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
          	vim.g.disable_autoformat = false
          end
        '';
      };
    };
    FormatDisable = {
      bang = true;
      desc = "Disable autoformating";
      command = {
        __raw = ''
          function(args)
            if args.bang then
              -- FormatDisable! will disable formatting just for this buffer
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end
        '';
      };
    };
  };

  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = {
        lsp_format = "fallback";
        quiet = false;
        timeout_ms = 1000;
      };
      format_on_save = ''
        	function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end
      '';
      notify_no_formatters = true;
      notify_on_error = true;
      formattersByFt = {
        nix = ["alejandra"];
        javascript = ["biome"];
        typescript = ["biome"];
        bash = ["shfmt"];
        sql = ["sqlfluff"];
        python = ["black"];
      };
      formatters = {
        black = {
          command = lib.getExe pkgs.black;
        };
        sqlfluff = {
          command = lib.getExe pkgs.sqlfluff;
        };
        alejandra = {
          command = lib.getExe pkgs.alejandra;
        };
        shfmt = {
          command = lib.getExe pkgs.shfmt;
        };
        biome = {
          command = lib.getExe pkgs.biome;
        };
      };
    };
  };
}
