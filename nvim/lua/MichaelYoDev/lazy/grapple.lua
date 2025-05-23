return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git", -- also try out "git_branch"
        icons = false, -- setting to "true" requires "nvim-web-devicons"
        status = false,
        win_opts = {
            border = "rounded",
            footer = "", -- disable footer
        },
    },
    keys = {
        { "<leader>a", "<cmd>Grapple toggle<cr>" },
        { "<C-e>",     "<cmd>Grapple toggle_tags<cr>" },

        { "<C-h>",     "<cmd>Grapple select index=1<cr>" },
        { "<C-j>",     "<cmd>Grapple select index=2<cr>" },
        { "<C-k>",     "<cmd>Grapple select index=3<cr>" },
        { "<C-l>",     "<cmd>Grapple select index=4<cr>" },
    },
}
