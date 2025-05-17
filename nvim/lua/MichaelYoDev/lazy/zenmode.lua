return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                    width = 0.16 * 4,
                    height = 0.14 * 4,
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


