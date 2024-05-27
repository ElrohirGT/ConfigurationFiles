{
  keymaps = [
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
      key = "<leader>e";
      action = ":Oil<CR>";
      options = {
        desc = "Toggle Oil";
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
      mode = "x";
      key = "<leader>p";
      action = "\"_dP";
    }

    {
      mode = "n";
      key = "<leader>y";
      action = "\"+y";
      options = {
        desc = "Yank to system clipboard";
      };
    }
    {
      mode = "v";
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
      mode = "n";
      key = "<leader>rn";
      action = ":IncRename ";
      options = {
        desc = "Rename symbols using IncRename";
      };
    }

    {
      mode = "n";
      key = "<leader>gl";
      action = ":Git log --oneline --graph<CR>";
      options = {
        desc = "Vim fugitive gitlog graph";
      };
    }
  ];
}
