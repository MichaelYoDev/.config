-- SET =========================================================================
local o = vim.opt
o.guicursor = ""
o.number = true
o.relativenumber = true
o.scrolloff = 8
o.signcolumn = "yes"
o.termguicolors = true
o.winborder = "rounded"

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.clipboard = "unnamedplus"
o.swapfile = false
o.undofile = true

o.ignorecase = true
o.smartcase = true

-- MARKDOWN ====================================================================
vim.keymap.set({ "n", "x", "v" }, "j", "gj", { buffer = 0 })
vim.keymap.set({ "n", "x", "v" }, "k", "gk", { buffer = 0 })

vim.cmd([[
	setlocal formatoptions+=t
	setlocal linebreak
	setlocal spell spelllang=en_us
	setlocal wrap
	setlocal wrapmargin=0
]])

-- LOCAL =======================================================================
local snippets = require("snippets")
local funcs = require("funcs")

-- PLUGINS =====================================================================
vim.pack.add({
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
})

require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

-- KEYMAPS =====================================================================
vim.g.mapleader = " "

local m = vim.keymap.set
m("i", "<C-e>", snippets.expand_snippet)
m("n", "<leader>pc", funcs.pack_clean)
m("n", "<leader>pg", funcs.pack_get)
m("n", "<leader>pu", vim.pack.update)
m("n", "<leader>w", "<CMD>write<CR>")
