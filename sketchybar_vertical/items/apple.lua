local colors = require("colors")
local icons = require("icons")

-- Padding item required because of bracket
sbar.add("item", { width = 5 })

local apple = sbar.add("item", {
    icon = {
        font = { size = 16.0 },
        string = icons.apple,
        padding_right = 6,
        padding_left = 6,
    },
    label = { drawing = false },
    background = {
        color = colors.bg2,
        border_color = colors.bg2,
        border_width = 2,
    },
    padding_left = 1,
    padding_right = 1,
    click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})

-- -- Double border for apple using a single item bracket
-- sbar.add("bracket", { apple.name }, {
--     background = {
--         color = colors.transparent,
--         height = 26,
--         -- border_color = colors.white,
--         -- border_width = 2,
--     },
-- })

-- Padding item required because of bracket
sbar.add("item", { width = 7 })

local separator = sbar.add("item", "separator", {
    position = "left",

    icon = { drawing = false },
    label = { icon = "-" },

    background = {
        color = colors.bg2,
        height = 2,
    },
})

return separator
