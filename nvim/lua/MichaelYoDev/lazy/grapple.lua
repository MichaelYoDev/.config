return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git", -- also try out "git_branch"
        icons = false, -- setting to "true" requires "nvim-web-devicons"
        status = false,
        win_opts = {
            border = "rounded",
        },
    },
    keys = {
        { "<leader>a", "<cmd>Grapple toggle<cr>" },
        { "<C-e>",     "<cmd>Grapple toggle_tags<cr>" },

        { "<leader>h", "<cmd>Grapple select index=1<cr>" },
        { "<leader>j", "<cmd>Grapple select index=2<cr>" },
        { "<leader>k", "<cmd>Grapple select index=3<cr>" },
        { "<leader>l", "<cmd>Grapple select index=4<cr>" },
    },
}
