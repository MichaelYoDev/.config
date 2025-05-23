local colors = require("colors")

function parse_string_to_table(s)
  local result = {}
  for line in s:gmatch("([^\n]+)") do
    table.insert(result, line)
  end
  return result
end

local file = io.popen("aerospace list-workspaces --all")
local result = file:read("*a")
file:close()

local workspaces = parse_string_to_table(result)

-- Create an array to store space item names for the bracket
local space_names = {}
for i, workspace in ipairs(workspaces) do
  local space = sbar.add("item", "space." .. i, {
    icon = {
      string = "●",
      color = colors.white,
      highlight_color = colors.red,
    },
    label = { drawing = false },
    padding_left = (i == 1) and 8 or 2,    -- Increased padding for the first item
    padding_right = (i == #workspaces) and 8 or 2, -- Increased padding for the last item
  })

  -- Store the space item name
  table.insert(space_names, space.name)

  space:subscribe("aerospace_workspace_change", function(env)
    local selected = env.FOCUSED_WORKSPACE == workspace
    space:set({
      icon = {
        -- string = selected and "●" or "◯", -- Set ● for selected, ○ for unselected
        highlight = selected
      },
      label = { highlight = selected },
      background = { border_color = colors.bg2 }
    })
  end)
end

-- Add a bracket around all space items to create an outer border
local space_bracket = sbar.add("bracket", space_names, {
  background = {
    color = colors.transparent,
    border_color = colors.bg2, -- Border color for the outer outline
    border_width = 2,         -- Border thickness
    height = 28
  }
})


local spaces_indicator = sbar.add("item", {
  padding_left = -3,
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
}
)

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

