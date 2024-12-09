{pkgs, ...}: {
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

  autoCmd = [
    {
      event = ["BufWritePost"];
      pattern = ["*.nix"];
      callback = {
        __raw = ''
          function(args)
          	if not vim.b.disable_autoformat then
          		vim.cmd("!${pkgs.alejandra}/bin/alejandra %")
          	end
          end
        '';
      };
    }
  ];
}
