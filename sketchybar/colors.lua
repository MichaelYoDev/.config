local themes = {
    dark = {
        name = "dark",

        -- rosepine
        black = 0xff191724,
        white = 0xffe0def4,
        red = 0xffeb6f92,
        green = 0xff9ccfd8,
        blue = 0xff31748f,
        yellow = 0xfff6c177,
        orange = 0xffebbcba,
        magenta = 0xffc4a7e7,
        grey = 0xff6e6a86,
        transparent = 0x00000000,

        bar = {
            bg = 0xff191724,
            border = 0xff2c2e34,
        },

        popup = {
            bg = 0xff1f1d2e,
            border = 0xff7f8490,
        },

        bg1 = 0xff26233a,
        bg2 = 0xff403d52,
    },

    light = {
        name = "light",

        -- rosepine dawn
        black = 0xfffaf4ed,
        white = 0xff575279,
        red = 0xffb4637a,
        green = 0xff56949f,
        blue = 0xff286983,
        yellow = 0xffea9d34,
        orange = 0xffd7827e,
        magenta = 0xff907aa9,
        grey = 0xff9893a5,
        transparent = 0x00000000,

        bar = {
            bg = 0xfffaf4ed,
            border = 0xfffffaf3,
        },

        popup = {
            bg = 0xfffffaf3,
            border = 0xff9893a5,
        },

        bg1 = 0xfff2e9e1,
        bg2 = 0xffdfdad9,
    },
}

-- Pick the palette matching the current system appearance
local active = themes.dark
local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
local style = handle:read("*l")
handle:close()
if style ~= "Dark" then
    active = themes.light
end

-- Proxy table: every color lookup resolves against the active palette at
-- read time, so a theme switch takes effect for anything that re-reads colors.
local colors = setmetatable({}, {
    __index = function(_, key)
        return active[key]
    end,
})

function colors.get_theme()
    return active.name
end

function colors.set_theme(name)
    active = themes[name] or active
end

function colors.with_alpha(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then
        return color
    end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

return colors
