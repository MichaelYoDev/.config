vim.g.mapleader = " "

-- netrw
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- vim.keymap.set("n", "<leader>pv", "<cmd>Explore<CR>")

-- oil.nvim
vim.keymap.set({ "n", "x" }, "<leader>pv", "<CMD>Oil<Cr>")

vim.keymap.set("n", "<leader>ep", "<cmd>ExportPicker<CR>")

-- move lines up/down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- join next line with cursor in same position
vim.keymap.set("n", "J", "mzJ`z")

-- scrolling/search
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over, but keep in register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without putting into register
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.config/scripts/tmux-sessionizer.sh<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- quickfix/location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- chmod
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- LMAOOOOOO
vim.keymap.set("n", "<leader>rain", "<cmd>CellularAutomaton make_it_rain<CR>");
vim.keymap.set("n", "<leader>life", "<cmd>CellularAutomaton game_of_life<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
