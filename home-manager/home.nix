{ config, pkgs, ... }:

 let my-python-packages = p: with p; [                                                                  
#       simpy                                                                                            
#       autopep8           
#       numpy                                       
#       networkx     
    ];                          
  in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "elrohirgt";
  home.homeDirectory = "/home/elrohirgt";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
     # Programming                                                                                        
        heaptrack                   
        gh # Git CLI client                         
        gcc         
        cppcheck                
        arduino-cli                                 
                                                    
        # Microcontrollers                                                                               
        # realvnc-vnc-viewer
        gnome.vinagre                               
        novnc 
        rpi-imager          
                                                                                                         
        # UML                                 
        plantuml                      
        graphviz                                    
                                                    
        # Go                  
        gopls              
        go                                       
                                                    
        # PHP                                                                                            
        php82                                       
        php82Packages.composer                                                                           
        phpactor # Language server                  
                                                    
        # SQL                 
        sqls # Language server   
        oracle-instantclient
        pgmanage                                    
                                                    
        # Javascript                              
        nodejs                                      
        yarn                                                                                             
                                                    
        # Kotlin                                                                                         
        kotlin                                                                                           
        kotlin-language-server

	# Nix support
        nil               
                                                    
    # Markdown LSP
    marksman

    # Java development
        jdk17
        # jprofiler # This profiler is commented because the free trial expired
        maven

    # C# development
        dotnet-sdk

        # C++ development
        ccls
        clang-tools

    # Python
        (python310Full.withPackages my-python-packages)
        nodePackages.pyright

    # Latex
        texlive.combined.scheme-medium
    texlab

    # Neovim Setup
    ripgrep # For Telescope
    wl-clipboard # For copying to system keyboard
    gdb # For debugging
    nerdfonts # For custom fonts
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "ElrohirGT";
    userEmail = "elrohirgt@gmail.com";
  };

  programs.tmux = {                                                                                                                                                                                          
    enable = true;                                                                                                                                                                                           
    extraConfig = ''                                                                                                                                                                                         
    # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/                                                                                                                  
    set -g default-terminal "xterm-256color"                                                                                                                                                               
    set -ga terminal-overrides ",*256col*:Tc"                                                                                                                                                              
    set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'                                                                                                                                                  
    set-environment -g COLORTERM "truecolor"                                                                                                                                                               
    
    # easy-to-remember split pane commands                                                                                                                                                                 
   bind | split-window -h -c "#{pane_current_path}"                                                                                                                                                       
   bind - split-window -v -c "#{pane_current_path}"                                                                                                                                                       
   
   # Vim-like movement between panes                                                                                                                                                                      
   bind -r k select-pane -U                                                                                                                                                                               
   bind -r j select-pane -D                                                                                                                                                                               
   bind -r h select-pane -L                                                                                                                                                                               
   bind -r l select-pane -R                                                                                                                                                                               
   '';                                                                                                                                                                                                      
   };

  programs.bat.enable = true;

   # Bash Configuration                                                                                                                                                                                       
    programs.bash = {                                                                                                                                                                                          
		enable = true;
		bashrcExtra = ''                                                                                                                                                                                
# Changes the default node modules installation path                                                                                                                                                     
export PATH=~/.npm-packages/bin:$PATH                                                                                                                                                                    
export NODE_PATH=~/.npm-packages/lib/node_modules  
	''; 
	    initExtra = ''
# Adds bindings to ctrl+f and ctrl+t to search inside documents.                                                                                                                                         
bind '"\C-f":"D=$(fd -td -a \".*\" ~/Documents/ | fzf) && cd \"$D\" && tmux \C-M"'                                                                                                                       
bind '"\C-t":"D=$(fd -td -a \".*\" ~/Documents/ | fzf) && cd \"$D\" && tmux new-session nix-shell\C-M"'                                                                                                  
		'';
		shellAliases = {
			e = "exit";                                                                                                                                                                                          
			graph = "git log --oneline --graph";                                                                                                                                                                 
			and = "android-studio > /dev/null 2>&1 &";                                                                                                                                                           
		};
   };

   programs.neovim = {                                                                                                                                                                                              
    enable = true;                                                                                                                                                                                                 
    viAlias = true;                               
    vimAlias = true;                              
	defaultEditor = true;
	extraLuaConfig = ''
		-- set relative line number
		vim.wo.relativenumber = true
		-- set the map leader for keybindings
		vim.g.mapleader = " "
		-- LSP Rename (inc-rename)
require("inc_rename").setup()

-- Color scheme
-- Default options:
require("kanagawa").setup({
    compile = true,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "dragon",              -- Load "wave" theme when "background" option is not set
    background = {               -- map the value of "background" option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ""
  })
end

sign({name = "DiagnosticSignError", text = ""})
sign({name = "DiagnosticSignWarn", text = ""})
sign({name = "DiagnosticSignHint", text = ""})
sign({name = "DiagnosticSignInfo", text = ""})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there"s only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {"menuone", "noselect", "noinsert"}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option("updatetime", 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Lightline configuration
vim.cmd("set noshowmode")

-- Rust tools config
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Completion Plugin Setup
local cmp = require"cmp"
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = "path" },                              -- file paths
    { name = "nvim_lsp", keyword_length = 3 },      -- from language server
    { name = "nvim_lsp_signature_help"},            -- display function signatures with current parameter emphasized
    { name = "nvim_lua", keyword_length = 2},       -- complete neovim"s Lua runtime API such vim.lsp.*
    { name = "buffer", keyword_length = 2 },        -- source current buffer
    { name = "vsnip", keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = "calc"},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {"menu", "abbr", "kind"},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = "λ",
              vsnip = "⋗",
              buffer = "Ω",
              path = "🖫",
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
  })

  -- Set up lspconfig.
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")
  -- Replace <YOUR_LSP_SERVER> with each lsp server you"ve enabled.
  lspconfig["marksman"].setup {
    capabilities = capabilities
  }
  lspconfig["texlab"].setup {
	  capabilities = capabilities
  }
  lspconfig["nil_ls"].setup {
	  capabilities = capabilities
  }
  lspconfig["kotlin_language_server"].setup {
	  capabilities = capabilities
  }
  lspconfig["gopls"].setup {
	  capabilities = capabilities
  }
  lspconfig["clangd"].setup {
	  capabilities = capabilities
  }
  lspconfig["phpactor"].setup {
	  capabilities = capabilities
  }
  lspconfig["sqls"].setup {
	  capabilities = capabilities
  }
  lspconfig["pyright"].setup {
	  capabilities = capabilities
  }


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    --vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    --vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    --vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    --vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    --vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set("n", "<space>wl", function()
      --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)
    --vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    --vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    --vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>fo", function()
		vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Nvim tree config (File Explorer)
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- use all default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- remove a default
    -- vim.keymap.del("n", "<C-E>", { buffer = bufnr })

    -- override a default
    -- vim.keymap.set("n", "<C-e>", api.tree.reload,                       opts("Refresh"))

    -- add your mappings
    ---
  end


-- OR setup with some options
require("nvim-tree").setup({
  on_attach = custom_attach,
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Editor Configuration
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "180"

vim.opt.spell = true

function EnglishSpelling()
	vim.opt.spelllang = "en_us"
end

function SpanishSpelling()
	vim.opt.spelllang = "es_gt"
end

vim.cmd([[
function OpenMarkdownPreview (url)
	execute "silent ! firefox --new-window " . a:url . " &"
endfunction
let g:mkdp_browserfunc = "OpenMarkdownPreview"
]])

function EnableWordWrap()
	vim.cmd("set wrap")
end

function DisableWordWrap()
	vim.cmd("set nowrap")
end

-- Keyboard shortcuts

-- Spelling
vim.keymap.set("n", "<leader>ls", SpanishSpelling)
vim.keymap.set("n", "<leader>le", EnglishSpelling)

vim.keymap.set("n", "<leader>we", EnableWordWrap)
vim.keymap.set("n", "<leader>ws", DisableWordWrap)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-Q>", ":wq<CR>")
vim.keymap.set("n", ":W", ":w")
vim.keymap.set("n", ":Q", ":q<CR>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>xx","<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")

-- Git (fugitive.nvim)
vim.keymap.set("n", "<leader>gl", ":Git log --oneline --graph<cr>")

-- Inc rename
vim.keymap.set("n", "<leader>rn", ":IncRename ")

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

vim.keymap.set("n", "<leader>d", require("telescope.builtin").lsp_definitions)
vim.keymap.set("n", "<leader>s", require("telescope.builtin").lsp_workspace_symbols)

-- Rust specific
vim.keymap.set("n", "<leader>tt", ":!cargo test<CR>")

-- Markdown
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>")
	'';
	plugins = with pkgs.vimPlugins; [
		# Color scheme                                                                                 
          kanagawa-nvim                                                                                  
                                                    
        # Markdown
		markdown-preview-nvim
                                                    
		# Status line
		lightline-vim

		# Kotlin
		kotlin-vim

		# Go
		go-nvim

		# C++
		vim-clang-format

		# Treesitter
		nvim-treesitter
		nvim-treesitter-parsers.rust
		nvim-treesitter-parsers.markdown
		nvim-treesitter-parsers.latex
		nvim-treesitter-parsers.nix
		nvim-treesitter-parsers.kotlin
		nvim-treesitter-parsers.go
		nvim-treesitter-parsers.cpp
		nvim-treesitter-parsers.php
		nvim-treesitter-parsers.sql
		nvim-treesitter-parsers.python

		nvim-lspconfig

		# Configuring the NVim LSP to use rust-analyzer
		rust-tools-nvim

		# Completion framework:
		nvim-cmp 
		# LSP completion source:
		cmp-nvim-lsp
		# LSP Rename
		inc-rename-nvim

		# Useful completion sources:
		cmp-nvim-lua
		cmp-nvim-lsp-signature-help
		cmp-vsnip                             
		cmp-path                              
		cmp-buffer                            
		vim-vsnip

		# Searching in projects
		telescope-nvim
		hop-nvim

		# Panels and other goodies                                                                                                                                                                        [4/353]
		nvim-tree-lua
		nvim-web-devicons
		tagbar
		todo-comments-nvim
		trouble-nvim
		comment-nvim
		vim-surround
		vim-be-good

		# For git
		vim-fugitive
	];
  };
}
