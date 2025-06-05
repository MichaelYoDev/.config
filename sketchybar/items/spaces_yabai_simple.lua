local colors = require("colors")
local sbar = require("sketchybar")
local icons = require("icons")
local settings = require("settings")

for i = 1, 10 do
	local space = sbar.add("space", "space." .. i, {
		position = "left",
		space = i,
		icon = { width = 7 },
		background = {
			corner_radius = 10,
			height = 14,
			padding_left = i == 1 and 7 or 0,
			padding_right = 7,
		},
	})

	space:subscribe("space_change", function (env)
		local selected = env.SELECTED == "true"
		sbar:animate("tanh", 15, function()
			space:set({
				icon = { width = selected and 31 or 7 },
				background = { color = selected and colors.red or colors.white},
			})
		end)
	end)
end

sbar.add("bracket", { "/space\\.\\d*/" }, {
	blur_radius = 32,
	background = {
		color = colors.transparent,
        border_color = colors.bg2,
        border_width = 2,
		height = 28,
	},
})

local spaces_indicator = sbar.add("item", {
    padding_left = 3,
    padding_right = 0,
    icon = {
        padding_left = 8,
        padding_right = 9,
        color = colors.grey,
        string = icons.switch.on,
    },
    label = {
        width = 0,
        padding_left = 0,
        padding_right = 8,
        string = "Spaces",
        color = colors.bg1,
        font = {
            style = settings.font.style_map["Regular"],
            size = 14.0,
        },
    },
    background = {
        color = colors.with_alpha(colors.grey, 0.0),
        border_color = colors.with_alpha(colors.bg1, 0.0),
    }
})

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
    local currently_on = spaces_indicator:query().icon.value == icons.switch.on
    spaces_indicator:set({
        icon = currently_on and icons.switch.off or icons.switch.on
    })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
    sbar.animate("tanh", 30, function()
        spaces_indicator:set({
            background = {
                color = { alpha = 1.0 },
                border_color = { alpha = 1.0 },
            },
            icon = { color = colors.bg1 },
            label = { width = "dynamic" }
        })
    end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
    sbar.animate("tanh", 30, function()
        spaces_indicator:set({
            background = {
                color = { alpha = 0.0 },
                border_color = { alpha = 0.0 },
            },
            icon = { color = colors.grey },
            label = { width = 0 }
        })
    end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
    sbar.trigger("swap_menus_and_spaces")
end)

