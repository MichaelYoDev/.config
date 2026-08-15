local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", { width = 5 })

local apple = sbar.add("item", {
	icon = {
		font = { size = 16.0 },
		string = icons.apple,
		color = colors.white,
		padding_right = 6,
		padding_left = 6,
	},
	label = { drawing = false },
	background = {
		color = colors.bg2,
		border_color = colors.black,
		border_width = 1,
	},
	padding_left = 1,
	padding_right = 1,
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})

-- Double border for apple using a single item bracket
local apple_bracket = sbar.add("bracket", { apple.name }, {
	background = {
		color = colors.transparent,
		height = 26,
		border_color = colors.grey,
	},
})

-- Padding item required because of bracket
sbar.add("item", { width = 7 })

apple:subscribe("theme_change", function()
	apple:set({
		icon = { color = colors.white },
		background = {
			color = colors.bg2,
			border_color = colors.black,
		},
	})
end)

apple_bracket:subscribe("theme_change", function()
	apple_bracket:set({
		background = { border_color = colors.grey },
	})
end)
