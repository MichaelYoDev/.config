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
vim.lsp.enable({ 'bashls', 'cssls', 'gopls', 'harper_ls', 'html', 'jdtls', 'lua_ls', 'markdown_oxide', 'pylsp',
    'rust_analyzer', 'tinymist', 'ts_ls' })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-config', { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- PLUGINS =====================================================================
vim.pack.add({
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/echasnovski/mini.nvim' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',          version = 'main' },
    { src = 'https://github.com/rose-pine/neovim' },
    { src = 'https://github.com/shortcuts/no-neck-pain.nvim',              version = 'main' },
    { src = 'https://github.com/stevearc/oil.nvim' },
})

require('mason').setup()
require('mini.icons').setup()
require('mini.pick').setup()
require('no-neck-pain').setup({ width = 130, buffers = { wo = { fillchars = 'eob: ' } } })
require('oil').setup({ view_options = { show_hidden = true }, columns = {} })
require('rose-pine').setup({ styles = { transparency = true } })
vim.cmd.colorscheme('rose-pine')

-- KEYMAPS =====================================================================
vim.g.mapleader = ' '

local m = vim.keymap.set
local snippets = require('snippets')

m('i', '<C-e>', snippets.expand)

m('n', '<leader>e', '<CMD>Oil<CR>')
m('n', '<leader>f', '<CMD>Pick files<CR>')
m('n', '<leader>h', '<CMD>Pick help<CR>')
m('n', '<leader>lf', vim.lsp.buf.format)
m('n', '<leader>ls', [[:%s/\s\+$//e<CR>]])
m('n', '<leader>m', '<CMD>Mason<CR>')
m('n', '<leader>pu', vim.pack.update)
m('n', '<leader>z', '<CMD>NoNeckPain<CR>')

m({ 'n', 'v' }, '<leader>c', '1z=') -- btw this fixes spelling for word under cursor

m({ 'n', 'x', 'v' }, 'j', 'gj')
m({ 'n', 'x', 'v' }, 'k', 'gk')
