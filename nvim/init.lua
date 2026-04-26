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
o.showmode = false

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

o.showtabline = 2
o.statusline = [[%!v:lua.require('stuff').MyStatusLine()]]
o.tabline = [[%!v:lua.require('stuff').BufferTabline()]]

-- LSP =========================================================================
vim.lsp.enable({ 'bashls', 'cssls', 'gopls', 'harper_ls', 'html', 'jdtls', 'lua_ls', 'pylsp', 'rust_analyzer', 'tinymist',
    'tombi', 'ts_ls' })

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

-- AUTOCOMMANDS =================================================================
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

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end,
})

-- PLUGINS =====================================================================
vim.pack.add({
    { src = 'https://github.com/brianhuster/live-preview.nvim' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/neanias/everforest-nvim',         name = 'everforest' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/f-person/auto-dark-mode.nvim' }
})

require('mini.pick').setup()
require('everforest').setup({ background = 'hard', transparent_background_level = 1 })
vim.cmd.colorscheme('everforest')

-- KEYMAPS =====================================================================
vim.g.mapleader = ' '

local m = vim.keymap.set
local snippets = require('snippets')

m('i', '<C-e>', snippets.expand)
m('n', '<C-f>', '<CMD>Open .<CR>')

m('n', '<leader>bd', ':bdelete<CR>')

m('n', '<leader>e', '<CMD>Ex<CR>')
m('n', '<leader>f', '<CMD>Pick files<CR>')
m('n', '<leader>h', '<CMD>Pick help<CR>')
m('n', '<leader>g', '<CMD>Pick grep_live<CR>')

m('n', '<leader>lf', vim.lsp.buf.format)

m('x', '<leader>p', '"_dP')
m({ 'n', 'v' }, '<leader>d', '"_d')
