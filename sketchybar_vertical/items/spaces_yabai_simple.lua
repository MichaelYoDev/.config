local colors = require("colors")
local sbar = require("sketchybar")

-- get number of spaces for padding
local handle = io.popen("yabai -m query --spaces | jq length")
local result = handle:read("*a")
handle:close()
local total_spaces = tonumber(result)

-- add spaces as dots with padding based on space number
for i = 1, total_spaces do
	local space = sbar.add("space", "space." .. i, {
		position = "left",
		space = i,
		icon = { width = 5 },
		background = {
			corner_radius = 15,
			height = 12,
			padding_left = i == 1 and 7 or 2,
			padding_right = i == total_spaces and 7 or 2,
		},
	})

    -- on space change, animate the workspace change with longer indicator
	space:subscribe("space_change", function (env)
		local selected = env.SELECTED == "true"
		sbar:animate("tanh", 15, function()
			space:set({
				-- icon = { width = selected and 35 or 5 },
				icon = { height = selected and 35 or 5 }, -- VERTICAL
				background = {
                    color = selected and colors.red or colors.white,
                    height = selected and 35 or 12, -- VERTICAL
                },
			})
		end)
	end)
end
--
-- -- add bracket around the spaces
-- sbar.add("bracket", { "/space\\.\\d*/" }, {
-- 	background = {
-- 		color = colors.transparent,
--         border_color = colors.bg2,
--         border_width = 2,
-- 	},
-- })


local separator2 = sbar.add("item", "separator2", {
    position = "left",

    icon = { drawing = false },
    label = { icon = "-" },

    background = {
        color = colors.bg2,
        height = 2,
    },
})

return separator2
