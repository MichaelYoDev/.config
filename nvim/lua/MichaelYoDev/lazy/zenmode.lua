return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                    width = .90,
                    height = .90,
                    options = {
                        signcolumn = "no",
                        number = true,
                        relativenumber = false,
                        cursorline = false,
                        cursorcolumn = false,
                        foldcolumn = "0",
                        list = false,
                    }
                },
            }
            require("zen-mode").toggle()
            ColorMyPencils()
        end)
    end
}
