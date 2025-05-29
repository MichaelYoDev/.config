return {
    'stevearc/oil.nvim',
    opts = {
        view_options = {
            show_hidden = true,
        },
    },

    config = function()
        require("oil").setup({})
        vim.keymap.set({ "n", "x" }, "<leader>pv", function() require("oil").open() end, { silent = true })
    end
}
