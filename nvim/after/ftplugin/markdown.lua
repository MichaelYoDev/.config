vim.keymap.set({ "n", "x", "v" }, "j", "gj", { buffer = 0 })
vim.keymap.set({ "n", "x", "v" }, "k", "gk", { buffer = 0 })

vim.cmd([[
	setlocal conceallevel=2
	setlocal formatoptions+=t
	setlocal linebreak
	setlocal spell spelllang=en_us
	setlocal textwidth=80
	setlocal wrap
	setlocal wrapmargin=0
]])
