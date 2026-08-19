vim.opt_local.linebreak = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.wrap = true
vim.opt_local.wrapmargin = 0

local stuff = require('stuff')
vim.keymap.set('n', '<leader>mp', function()
    local input = vim.api.nvim_buf_get_name(0)
    stuff.markdown2pdf(input)
end)


vim.keymap.set({ "n", "x", "v" }, "j", "gj")
vim.keymap.set({ "n", "x", "v" }, "k", "gk")

m("n", "<leader>c", "0ci[x<C-[>0j", { desc = "check an unfinished checkbox" })
m("n", "<leader>d", "0ci[-<C-[>0j", { desc = "in-progress an unfinished checkbox" })
m("n", "<leader>n", "0i- [ ] ", { desc = "new checkbox" })

