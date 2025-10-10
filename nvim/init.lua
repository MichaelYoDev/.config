-- SET =========================================================================
local o = vim.opt
o.cursorline = true
o.guicursor = ''
o.number = true
o.relativenumber = true
o.scrolloff = 8
o.signcolumn = 'yes'
o.termguicolors = true
o.winborder = 'rounded'

o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.softtabstop = 4
o.tabstop = 4
o.wrap = false

o.clipboard = 'unnamedplus'
o.swapfile = false
o.undodir = os.getenv('HOME') .. '/.vim/undodir//'
o.undofile = true

o.ignorecase = true
o.smartcase = true

o.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert', 'popup' }

-- LSP =========================================================================
vim.lsp.enable({ 'bashls', 'cssls', 'gopls', 'harper_ls', 'html', 'jdtls', 'lua_ls', 'pylsp', 'rust_analyzer', 'tinymist',
    'ts_ls' })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('myLSP', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

-- AUTOCOMANDS =================================================================
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("TrimWhitespace", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- PLUGINS =====================================================================
vim.pack.add({
    { src = 'https://github.com/brianhuster/live-preview.nvim' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/neanias/everforest-nvim',                  name = 'everforest' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',          version = 'main' },
    { src = 'https://github.com/shortcuts/no-neck-pain.nvim',              version = 'main' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/szymonwilczek/vim-be-better' },
})

require('mason').setup()
require('mini.pick').setup()
require('no-neck-pain').setup({ width = 130, buffers = { wo = { fillchars = 'eob: ' } } })
require('oil').setup({ view_options = { show_hidden = true }, columns = {} })
require('everforest').setup({ background = 'hard', transparent_background_level = 1 })
vim.cmd.colorscheme('everforest')

-- KEYMAPS =====================================================================
vim.g.mapleader = ' '

local m = vim.keymap.set
local snippets = require('snippets')

m('i', '<C-e>', snippets.expand)
m('n', '<C-f>', '<CMD>Open .<CR>')

m('n', '<leader>e', '<CMD>Oil<CR>')
m('n', '<leader>f', '<CMD>Pick files<CR>')
m('n', '<leader>h', '<CMD>Pick help<CR>')
m('n', '<leader>g', '<CMD>Pick grep_live<CR>')
m('n', '<leader>z', '<CMD>NoNeckPain<CR>')

m('n', '<leader>lf', vim.lsp.buf.format)

m('x', '<leader>p', '"_dP')
m({ 'n', 'v' }, '<leader>d', '"_d')

m({ 'n', 'x', 'v' }, 'j', 'gj')
m({ 'n', 'x', 'v' }, 'k', 'gk')
