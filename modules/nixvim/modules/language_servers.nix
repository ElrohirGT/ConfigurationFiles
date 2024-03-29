{
  pkgs,
  lib,
  config,
  options,
  ...
}: {
  options.language-servers.isDefault = lib.mkOption {
    type = lib.types.nullOr lib.types.bool;
    description = "If set to false, some functionality will be disabled to save disk space.";
    default = true;
  };

  config = {
    plugins.lsp = {
      enable = true;
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
          "<leader>e" = "open_float";
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
          "<leader>rn" = {
            action = "rename";
            desc = "[R]e[n]ame";
          };
        };
      };
      servers = {
        # HTML
        html.enable = config.language-servers.isDefault;

        # Javascript / Typescript
        tsserver.enable = config.language-servers.isDefault;

        # Lua
        lua-ls.enable = true;

        # Go
        gopls.enable = config.language-servers.isDefault;

        # Gleam
        gleam.enable = config.language-servers.isDefault;

        # Bash
        bashls.enable = true;

        # Nix
        nil_ls.enable = true;

        # Markdown
        marksman.enable = true;

        # LaTex
        texlab.enable = config.language-servers.isDefault;
      };
    };

    plugins = {
      # Rust setup
      rustaceanvim.enable = config.general.isDefault;
    };

    extraPlugins =
      if config.language-servers.isDefault
      then
        with pkgs; [
          # SQL LSP setup
          sqls
          (pkgs.vimUtils.buildVimPlugin {
            name = "sqls.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "nanotee";
              repo = "sqls.nvim";
              rev = "4b1274b5b44c48ce784aac23747192f5d9d26207";
              # SHA-256 obtained using:
              # nix-prefetch-url --unpack https://github.com/nanotee/sqls.nvim/archive/4b1274b5b44c48ce784aac23747192f5d9d26207.tar.gz
              sha256 = "0jxgsajl7plw025a0h6r3cifrj0jyszn697247ggy0arlfvnx8cc";
            };
          })
        ]
      else [];
    extraConfigLua =
      if config.language-servers.isDefault
      then ''
         	require('lspconfig').sqls.setup{
           on_attach = function(client, bufnr)
             require('sqls').on_attach(client, bufnr) -- require sqls.nvim
           end;
           settings = {
             sqls = {
               connections = {
        {
                   driver = 'postgresql',
        	-- change the database attribute to whatever DB we're using right now
                   dataSourceName = 'host=localhost port=5432 user=postgres database=postgres',
                 },
               },
             },
           };
         }
      ''
      else "";
  };
}
