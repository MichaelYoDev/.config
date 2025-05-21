return { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
        -- better coments
        require('mini.comment').setup()

        -- Better Around/Inside textobjects
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        require('mini.surround').setup()

        -- Pair stuff like parenthesis
        require('mini.pairs').setup()

        -- Shows the scope of where you are typing
        require('mini.indentscope').setup({
            symbol = "▏",
            -- symbol = "│",
            options = { try_as_border = true },
            delay = 0,
            draw = { animation = require("mini.indentscope").gen_animation.none() },
        })
        require('mini.indentscope').gen_animation.none()

        -- Start page stuff
        local logo = {
            [[███╗   ██╗██╗   ██╗██╗███╗   ███╗]],
            [[████╗  ██║██║   ██║██║████╗ ████║]],
            [[██╔██╗ ██║██║   ██║██║██╔████╔██║]],
            [[██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
            [[██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║]],
            [[╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        }
        local system_info = {
            'Neovim v' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch,
        }
        -- require('mini.starter').setup({
        --     header = table.concat(vim.list_extend(logo, system_info), '\n'),
        -- })

        -- statusline!
        local statusline = require 'mini.statusline'
        -- set use_icons to true if you have a Nerd Font
        statusline.setup { use_icons = vim.g.have_nerd_font }

        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return '%2l:%-2v'
        end
    end,
}
