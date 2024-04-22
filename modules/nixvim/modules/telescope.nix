{pkgs, ...}: {
  plugins.telescope = {
    # Search through files inside workspace
    enable = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options = {
          desc = "[F]ind [f]iles in CWD";
        };
      };
      "<leader>fg" = {
        action = "live_grep";
        options = {
          desc = "[F]ind file according to content that matches [G]rep";
        };
      };
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "[F]ind on [B]uffers";
        };
      };
      "<leader>fc" = {
        action = "current_buffer_fuzzy_find";
        options = {
          desc = "[F]ind on [C]urrent buffer";
        };
      };
      "<leader>fh" = {
        action = "help_tags";
        options = {
          desc = "[F]ind [H]elp";
        };
      };
      "<leader>fd" = {
        action = "lsp_definitions";
        options = {
          desc = "[F]ind [D]efinitions";
        };
      };
      "<leader>fr" = {
        action = "lsp_references";
        options = {
          desc = "[F]ind [R]eferences";
        };
      };
      "<leader>fi" = {
        action = "lsp_implementations";
        options = {
          desc = "[F]ind [I]mplementations";
        };
      };
      "<leader>fs" = {
        action = "lsp_workspace_symbols";
        options = {
          desc = "[F]ind workspace [S]ymbols";
        };
      };
      "<leader>fw" = {
        action = "grep_string";
        options = {
          desc = "[F]ind current [W]ord";
        };
      };
    };
  };

  extraPackages = with pkgs; [
    ripgrep
  ];
}
