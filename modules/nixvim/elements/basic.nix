{
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

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # colorschemes.kanagawa.enable = true;
    colorschemes.nightfox = {
      enable = true;
      flavor = "nightfox";
    };

    plugins = {
      # Line information
      lualine.enable = true;

      # Plugin to find which key does what
      which-key.enable = true;

      # Better support for comments in NeoVim
      comment.enable = true;

      # Support for surrounding things with things
      vim-surround.enable = true;

      # Autoclose parenthesis, braces, etc.
      autoclose.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>zi";
        action = ":set foldmethod=indent<CR>";
        options = {
          desc = "Set folding method to use indentation";
        };
      }
      {
        mode = "n";
        key = "<leader>zt";
        action = ":set foldmethod=expr<CR>";
        options = {
          desc = "Set folding method to use treesitter";
        };
      }

      {
        mode = "n";
        key = "<leader>n";
        action = ":vnew<CR>";
        options = {
          desc = "Create a new vertical split with an empty buffer";
        };
      }

      # Vim terminal
      {
        mode = "n";
        key = "<C-J>";
        action = ":vnew<CR>:terminal<CR>";
        options = {
          desc = "Create a new vertical split with a terminal buffer";
        };
      }

      {
        mode = "t";
        key = "<ESC>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Enter normal mode without closing the terminal";
        };
      }

      # Other stuff
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options = {
          desc = "Move selected lines one line below";
        };
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options = {
          desc = "Move selected lines on line above";
        };
      }

      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
        options = {
          desc = "Append next line to current line";
        };
      }

      {
        mode = "n";
        key = "<C-Q>";
        action = ":wq<CR>";
        options = {
          desc = "Saves and closes file";
        };
      }

      {
        mode = "n";
        key = ":W";
        action = ":w";
        options = {
          desc = "Saves file, makes it so :w is case insensitive";
        };
      }
      {
        mode = "n";
        key = ":Q";
        action = ":q<CR>";
        options = {
          desc = "Quits the  file, makes it so :q is case insensitive";
        };
      }

      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options = {
          desc = "Half page down, centers cursor on screen";
        };
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options = {
          desc = "Half page up, centers cursor on screen";
        };
      }

      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options = {
          desc = "Next in search, centers cursor on screen";
        };
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options = {
          desc = "Previous in search, centers cursor on screen";
        };
      }

      {
        mode = ["n" "v"];
        key = "<leader>y";
        action = "\"+y";
        options = {
          desc = "Yank to system clipboard";
        };
      }
      {
        mode = "n";
        key = "<leader>Y";
        action = "\"+Y";
        options = {
          desc = "Yank to system clipboard";
        };
      }

      {
        mode = "n";
        key = "Q";
        action = "<nop>";
        options = {
          desc = "Disable Q";
        };
      }

      {
        mode = ["n" "x"];
        key = "<leader>p";
        action = "\"0p";
        options = {
          desc = "Paste from yank register";
        };
      }
    ];
  };
}
