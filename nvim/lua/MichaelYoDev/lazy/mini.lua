return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.diff').setup()

        require('mini.icons').setup()

        require('mini.indentscope').setup({
            symbol = "▏",
            options = { try_as_border = true },
            delay = 0,
            draw = { animation = require("mini.indentscope").gen_animation.none() },
        })

        require('mini.pairs').setup()
    end,
}
