{
  imports = [../atoms/sqls.nix];

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
          "<c-s>" = {
            action = "signature_help";
            desc = "[S]ignature help from the LSP";
          };
        };
      };
    };
  };
}
