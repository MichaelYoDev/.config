local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Convert integer to Roman numeral (1 to 10)
local function to_roman(num)
    local roman_map = {
        [1] = "I",
        [2] = "II",
        [3] = "III",
        [4] = "IV",
        [5] = "V",
        [6] = "VI",
        [7] = "VII",
        [8] = "VIII",
        [9] = "IX",
        [10] = "X"
    }
    return roman_map[num] or tostring(num)
end

local spaces = {}

for i = 1, 10, 1 do
    local space = sbar.add("space", "space." .. i, {
        space = i,
        icon = {
            font = { family = settings.font.numbers },
            string = to_roman(i),
            padding_left = 13,
            color = colors.white,
            highlight_color = colors.red,
        },
        label = {
            padding_left = 8,
            padding_right = 13,
            color = colors.grey,
            highlight_color = colors.white,
            font = "sketchybar-app-font:Regular:15.0",
        },
        padding_right = 1,
        padding_left = 1,
        background = {
            color = colors.bg1,
            border_width = 1,
            height = 22,
            border_color = colors.black,
        },
        popup = { background = { border_width = 5, border_color = colors.black } }
    })

    spaces[i] = space

    local space_bracket = sbar.add("bracket", { space.name }, {
        background = {
            color = colors.transparent,
            border_color = colors.bg2,
            height = 24,
            border_width = 2
        }
    })

    sbar.add("space", "space.padding." .. i, {
        space = i,
        script = "",
        width = settings.group_paddings,
    })

    local space_popup = sbar.add("item", {
        position = "popup." .. space.name,
        padding_left = 5,
        padding_right = 0,
        background = {
            drawing = true,
            image = {
                corner_radius = 9,
                scale = 0.2
            }
        }
    })

    space:subscribe("space_change", function(env)
        local selected = env.SELECTED == "true"
        local color = selected and colors.grey or colors.bg2
        space:set({
            icon = { highlight = selected },
            label = { highlight = selected },
            background = { border_color = selected and colors.black or colors.bg2 }
        })
        space_bracket:set({
            background = { border_color = selected and colors.grey or colors.bg2 }
        })
    end)

    space:subscribe("mouse.clicked", function(env)
        if env.BUTTON == "other" then
            space_popup:set({ background = { image = "space." .. env.SID } })
            space:set({ popup = { drawing = "toggle" } })
        else
            local op = (env.BUTTON == "right") and "--destroy" or "--focus"
            sbar.exec("yabai -m space " .. op .. " " .. env.SID)
        end
    end)

    space:subscribe("mouse.exited", function(_)
        space:set({ popup = { drawing = false } })
    end)
end

local space_window_observer = sbar.add("item", {
    drawing = false,
    updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
    local icon_line = ""
    local no_app = true
    for app, count in pairs(env.INFO.apps) do
        no_app = false
        local lookup = app_icons[app]
        local icon = ((lookup == nil) and app_icons["Default"] or lookup)
        icon_line = icon_line .. icon
    end

    if (no_app) then
        icon_line = ""
    end
    sbar.animate("tanh", 10, function()
        spaces[env.INFO.space]:set({
            label = {
                string = icon_line,
                padding_right = no_app and 2 or 13
            }
        })
    end)
end)
