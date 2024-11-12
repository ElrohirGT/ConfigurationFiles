{
  plugins = {
    luasnip.enable = true;
  };

  # Setting up the completion engine to use luasnip
  plugins.cmp.settings.snippet.expand = ''function(args) require('luasnip').lsp_expand(args.body) end'';

  keymaps = [
    {
      mode = ["i" "s"];
      key = "<c-j>";
      action = {
        __raw = ''
          function()
          local ls = require "luasnip"
          	if ls.expand_or_jumpable() then
          		ls.expand_or_jump()
          	end
          end
        '';
      };
      options = {
        silent = true;
        desc = "Jumps to the next snippet position";
      };
    }

    {
      mode = ["i" "s"];
      key = "<c-k>";
      action = {
        __raw = ''
          function()
          local ls = require "luasnip"
          	if ls.jumpable(-1) then
          		ls.jump(-1)
          	end
          end
        '';
      };
      options = {
        silent = true;
        desc = "Jumps to the previous snippet position";
      };
    }
  ];
}
