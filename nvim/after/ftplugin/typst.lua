vim.keymap.set("n", "<leader>te", "<CMD>LspTinymistExportPdf<CR>", { buffer = 0 })
vim.keymap.set("n", "<leader>tp", "<CMD>TypstPreview<CR>", { buffer = 0 })
vim.keymap.set({ "n", "x", "v" }, "j", "gj", { buffer = 0 })
vim.keymap.set({ "n", "x", "v" }, "k", "gk", { buffer = 0 })

vim.cmd([[
	setlocal formatoptions+=t
	setlocal linebreak
	setlocal spell spelllang=en_us
	setlocal wrap
	setlocal wrapmargin=0
]])
