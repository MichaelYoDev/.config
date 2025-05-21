return {
    "sylvanfranklin/omni-preview.nvim",
    dependencies = {
        -- Typst
        { 'chomosuke/typst-preview.nvim', lazy = true },

        -- CSV
        { 'hat0uma/csvview.nvim',         lazy = true },

        -- Markdown
        {
            "toppair/peek.nvim",
            event = { "VeryLazy" },
            build = "deno task --quiet build:fast",
        },
        -- { "OXY2DEV/markview.nvim", lazy = false },

    },
    opts = {},
    keys = {
        { "<leader>po", "<cmd>OmniPreview start<CR>", desc = "OmniPreview Start" },
    }
}
