{
  imports = [../atoms/sqls-nvim.nix];

  config = {
    plugins.lsp = {
      enable = true;
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
          "<leader>of" = "open_float";
        };

        # All keymaps of the form vim.lsp.buf.<action>
        lspBuf = {
          K = "hover";
          gr = {
            action = "references";
            desc = "[G]oto [R]eferences";
          };
          gd = {
            action = "definition";
            desc = "[G]oto [D]efinition";
          };
          gi = {
            action = "implementation";
            desc = "[G]oto [I]mplementation";
          };
          gt = {
            action = "type_definition";
            desc = "[G]oto [T]ype definitions";
          };
          "<leader>ca" = {
            action = "code_action";
            desc = "[C]ode [A]ctions";
          };
          # "<leader>rn" = {
          #   action = "rename";
          #   desc = "[R]e[n]ame";
          # };
        };
      };
      servers = {
        # HTML
        html.enable = true;

        # CSS
        cssls.enable = true;

        # Javascript / Typescript
        tsserver.enable = true;

        # Lua
        lua-ls.enable = true;

        # Go
        gopls.enable = true;

        # Gleam
        gleam.enable = true;

        # Bash
        bashls.enable = true;

        # Nix
        nil_ls.enable = true;

        # Markdown
        marksman.enable = true;

        # LaTex
        texlab.enable = true;

        # Elm language support
        elmls.enable = true;
      };
    };

    plugins = {
      # Rust setup
      rustaceanvim.enable = true;
    };
  };
}
