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
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

-- PLUGINS =====================================================================
vim.pack.add({
    { src = 'https://github.com/brianhuster/live-preview.nvim' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/nvim-mini/mini.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',          version = 'main' },
    { src = 'https://github.com/rose-pine/neovim',                         name = 'rose-pine' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    --
})

require('mason').setup()
require('mini.pick').setup()
-- require('oil').setup({ view_options = { show_hidden = true }, columns = {} })
require("oil").setup({
    columns = {},
    lsp_file_methods = { autosave_changes = true },
    view_options = { show_hidden = true },
    float = { max_width = 0.7, max_height = 0.6, border = "rounded" },
})

require('render-markdown').setup({ file_types = { 'markdown' } })
require('rose-pine').setup({ styles = { transparency = true } })
vim.cmd.colorscheme('rose-pine')

-- KEYMAPS =====================================================================
vim.g.mapleader = ' '

local m = vim.keymap.set
local snippets = require('snippets')

m('i', '<C-e>', snippets.expand)

-- m('n', '<leader>e', '<CMD>Oil<CR>')
m('n', '<leader>e', require("oil").open_float)
m('n', '<leader>f', '<CMD>Pick files<CR>')
m('n', '<leader>h', '<CMD>Pick help<CR>')

m('n', '<leader>ps', '<CMD>LivePreview start<CR>')
m('n', '<leader>pc', '<CMD>LivePreview close<CR>')

m('n', '<leader>lf', vim.lsp.buf.format)
m('n', '<leader>ls', [[:%s/\s\+$//e<CR>]], { silent = true })
m('n', '<leader>s', '1z=')

m({ 'n', 'x', 'v' }, 'j', 'gj')
m({ 'n', 'x', 'v' }, 'k', 'gk')
