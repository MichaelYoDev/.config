local colors = require("colors")

local function detect_appearance()
    local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
    local style = handle:read("*l")
    handle:close()
    return (style == "Dark") and "dark" or "light"
end

local function apply(theme)
    colors.set_theme(theme)
    require("bar").apply()
    require("default").apply()
    -- Let every item re-apply its own colors against the new palette.
    sbar.trigger("theme_change", {})
end

-- Fires whenever the system appearance (light/dark) changes
sbar.add("event", "theme_change", "AppleInterfaceThemeChangedNotification")

local theme = {
    detect = detect_appearance,
    apply = apply,

    watch = function()
        local watcher = sbar.add("item", {
            drawing = false,
            updates = true,
            update_freq = 60,
        })

        -- theme_change fires on light/dark toggles; system_woke + routine are
        -- fallbacks in case the notification is missed (e.g. while asleep).
        watcher:subscribe({ "theme_change", "system_woke", "routine" }, function()
            local detected = detect_appearance()
            if detected ~= colors.get_theme() then
                apply(detected)
            end
        end)
    end,
}

return theme
