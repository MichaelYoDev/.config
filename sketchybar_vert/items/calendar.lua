local settings = require("settings")
local colors = require("colors")

-- Optional padding before the group
sbar.add("item", { position = "center", width = settings.group_paddings })

-- Four separate items for each line
local cal_weekday = sbar.add("item", {
    icon = {
        string = "",
        color = colors.white,
        font = { style = settings.font.style_map["Black"], size = 13.0 },
    },
    label = { drawing = false },
    position = "center",
    update_freq = 3,
})

local cal_day = sbar.add("item", {
    icon = {
        string = "",
        color = colors.white,
        font = { style = settings.font.style_map["Black"], size = 13.0 }, -- bigger for the day number
    },
    label = { drawing = false },
    position = "center",
    update_freq = 3,
})

local cal_month = sbar.add("item", {
    icon = {
        string = "",
        color = colors.white,
        font = { style = settings.font.style_map["Black"], size = 13.0 },
    },
    label = { drawing = false },
    position = "center",
    update_freq = 3,
})

local separator4 = sbar.add("item", "separator4", {
    position = "center",

    icon = { drawing = false },
    label = { icon = "-" },

    background = {
        color = colors.bg2,
        height = 2,
    },
})

local cal_hour = sbar.add("item", {
    icon = {
        string = "",
        color = colors.white,
        font = { style = settings.font.style_map["Black"], size = 13.0 },
    },
    label = { drawing = false },
    position = "center",
    update_freq = 3,
})

local cal_min = sbar.add("item", {
    icon = {
        string = "",
        color = colors.white,
        font = { style = settings.font.style_map["Black"], size = 13.0 },
    },
    label = { drawing = false },
    position = "center",
    update_freq = 3,
})

-- Update function
local function update_calendar()
    cal_weekday:set({ icon = os.date("%a") })
    cal_day:set({ icon = os.date("%d") })
    cal_month:set({ icon = os.date("%b") })
    cal_hour:set({ icon = os.date("%H") })
    cal_min:set({ icon = os.date("%M") })
end

cal_weekday:subscribe({ "forced", "routine", "system_woke" }, update_calendar)
cal_day:subscribe({ "forced", "routine", "system_woke" }, update_calendar)
cal_month:subscribe({ "routine", "system_woke" }, update_calendar)
cal_hour:subscribe({ "forced", "routine", "system_woke" }, update_calendar)
cal_min:subscribe({ "forced", "routine", "system_woke" }, update_calendar)

update_calendar()
return separator4
