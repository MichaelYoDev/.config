vim.keymap.set("n", "<leader>te", "<CMD>LspTinymistExportPdf<CR>", { buffer = 0 })
vim.keymap.set("n", "<leader>tp", "<CMD>TypstPreview<CR>", { buffer = 0 })
vim.keymap.set({ "n", "x", "v" }, "j", "gj")
vim.keymap.set({ "n", "x", "v" }, "k", "gk")

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true

vim.opt_local.linebreak = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.wrap = true
vim.opt_local.wrapmargin = 0
