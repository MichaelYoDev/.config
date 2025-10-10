vim.opt_local.linebreak = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.wrap = true
vim.opt_local.wrapmargin = 0

vim.keymap.set('n', '<leader>mp', '<CMD>!bash ~/.config/scripts/term/markdown2pdf.sh %:p<CR>')
