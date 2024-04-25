{
  pkgs,
  lib,
  config,
  ...
}: {
  options.general.isDefault = with lib;
    mkOption {
      type = types.nullOr types.bool;
      description = "If set to false, some functionality will be disabled to save disk space.";
      default = true;
    };

  config = {
    # :h option-list
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;

      expandtab = false;
      hlsearch = false;
      incsearch = true;

      scrolloff = 8;
      updatetime = 50;
      colorcolumn = "180";

      spell = true;
      termguicolors = true;
    };

    autoGroups = {
      "kickstart-highlight-yank" = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = "TextYankPost";
        desc = "Highlight when yanking text";
        group = "kickstart-highlight-yank";
        callback = {
          __raw = ''
            function ()
            	vim.highlight.on_yank()
            end
          '';
        };
      }
    ];

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # colorschemes.oxocarbon.enable = true;
    colorschemes.kanagawa.enable = true;
    plugins = {
      # Line information
      lualine.enable = true;

      # Plugin to find which key does what
      which-key.enable = true;

      # HTML and JSX Tags
      ts-autotag.enable = true;
      # Vim CSS plugin to display color
      nvim-colorizer.enable = true;

      # Manage files in neovim buffer
      oil.enable = config.general.isDefault;

      # Rename incrementally with LSP support
      inc-rename.enable = true;

      # Display tags inside a file
      tagbar.enable = true;

      # LaTex setup
      vimtex = {
        enable = config.general.isDefault;
        texlivePackage = null; # Dont install any package
      };

      # TODO and friends formatting for comments
      todo-comments.enable = true;

      # Better support for comments in NeoVim
      comment.enable = true;

      # Support for surrounding things with things
      surround.enable = true;

      # PlantUML support
      plantuml-syntax = {
        enable = config.general.isDefault;
        executableScript = "${pkgs.plantuml}/bin/plantuml";
      };
    };

    extraPlugins = with pkgs; [
      vimPlugins.nvim-web-devicons
      plantuml
    ];

    extraConfigLua = ''
      -- LSP Diagnostics Options Setup
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = ""
        })
      end

      -- Diagnostic Icons
      sign({name = "DiagnosticSignError", text = ""})
      sign({name = "DiagnosticSignWarn", text = ""})
      sign({name = "DiagnosticSignHint", text = ""})
      sign({name = "DiagnosticSignInfo", text = ""})
    '';
  };
}
