-- LSP Rename (inc-rename)
require("inc_rename").setup()

-- Color scheme
-- Default options:
require('kanagawa').setup({
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
    theme = "dragon",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
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
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

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
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  lspconfig['marksman'].setup {
    capabilities = capabilities
  }
  lspconfig['texlab'].setup {
	  capabilities = capabilities
  }
  lspconfig['nil_ls'].setup {
	  capabilities = capabilities
  }
  lspconfig['kotlin_language_server'].setup {
	  capabilities = capabilities
  }
  lspconfig['gopls'].setup {
	  capabilities = capabilities
  }
  lspconfig['clangd'].setup {
	  capabilities = capabilities
  }

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wl', function()
      --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)
    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<space>f', function()
      --vim.lsp.buf.format { async = true }
    --end, opts)
  end,
})

-- Nvim tree config (File Explorer)
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- use all default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- remove a default
    -- vim.keymap.del('n', '<C-E>', { buffer = bufnr })

    -- override a default
    -- vim.keymap.set('n', '<C-e>', api.tree.reload,                       opts('Refresh'))

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
	vim.opt.spelllang = 'en_us'
end

function SpanishSpelling()
	vim.opt.spelllang = 'es_gt'
end

vim.cmd([[
function OpenMarkdownPreview (url)
	execute "silent ! firefox --new-window " . a:url . " &"
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'
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
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-Q>', ':wq<CR>')
vim.keymap.set("n", ":W", ":w")
vim.keymap.set('n', ':Q', ':q<CR>')

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
vim.keymap.set("n", "<leader>cf", ":!cargo fmt<CR>")
vim.keymap.set("n", "<leader>tt", ":!cargo test<CR>")


-- Markdown
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>")
