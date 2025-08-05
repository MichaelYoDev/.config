-- SET
vim.opt.guicursor = ""
vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = false

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.pumblend = 0
vim.opt.winblend = 0
vim.opt.winborder = "rounded"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

vim.opt.conceallevel = 0

-- REMAP
vim.g.mapleader = " "

vim.keymap.set({ "n", "x" }, "<leader>e", "<CMD>Oil<Cr>")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>t', "<CMD>TypstPreview<Cr>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- AUTOCMDS
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 60 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("TrimWhitespace", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- LSP
vim.lsp.enable({ 'bash', 'vscode-css-language-server', 'gopls', 'vscode-html-language-server', 'jdtls', 'lua_ls', 'markdown_oxide', 'pylsp', 'rust_analyzer', 'ts_ls', 'tinymist' })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("lsp-config", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")


-- Snippets
-- none for now, maybe add later?

-- PACK
vim.pack.add({
    {src = "https://github.com/rose-pine/neovim"},
    {src = "https://github.com/xiyaowong/transparent.nvim"},
    {src = "https://github.com/szymonwilczek/vim-be-better"},
    {src = "https://github.com/echasnovski/mini.nvim"},
    {src = "https://github.com/neovim/nvim-lspconfig"},
    {src = "https://github.com/stevearc/oil.nvim"},
    {src = "https://github.com/MeanderingProgrammer/render-markdown.nvim"},
    {src = "https://github.com/chomosuke/typst-preview.nvim"},
    {src = "https://github.com/nvim-treesitter/nvim-treesitter"},
    {src = "https://github.com/mbbill/undotree"},
})

-- SETUP FOR PACK
require("rose-pine").setup({
    styles = {
        transparency = true,
    },
})
vim.cmd("colorscheme rose-pine")
vim.cmd(":hi statusline guibg=NONE")

require('mini.diff').setup()

require('mini.icons').setup()

require('mini.indentscope').setup({
    symbol = "▏",
    options = { try_as_border = true },
    delay = 0,
    draw = { animation = require("mini.indentscope").gen_animation.none() },
})

require('mini.pairs').setup()

require('mini.surround').setup()

require('mini.pick').setup()

require("oil").setup({
    view_options = {
        show_hidden = true,
    }
})

require("nvim-treesitter").setup()
