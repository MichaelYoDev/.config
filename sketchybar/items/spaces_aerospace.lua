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
