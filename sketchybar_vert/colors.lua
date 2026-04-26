return {
    -- -- rosepine
    -- black = 0xff191724,
    -- white = 0xffe0def4,
    -- red = 0xffeb6f92,
    -- green = 0xff9ccfd8,
    -- blue = 0xff31748f,
    -- yellow = 0xfff6c177,
    -- orange = 0xffebbcba,
    -- magenta = 0xffc4a7e7,
    -- grey = 0xff6e6a86,
    -- transparent = 0x00000000,
    --
    -- bar = {
    --     bg = 0xff191724,
    --     border = 0xff2c2e34,
    -- },
    --
    -- popup = {
    --     bg = 0xff1f1d2e,
    --     border = 0xff7f8490,
    -- },
    --
    -- bg1 = 0xff26233a,
    -- bg2 = 0xff403d52,

    -- everforest hard
    black = 0xff272e33,
    white = 0xffd3c6aa,
    red = 0xffe67e80,
    green = 0xffa7c080,
    blue = 0xff7fbbb3,
    yellow = 0xffdbbc7f,
    orange = 0xffe69875,
    magenta = 0xffd699b6,
    grey = 0xff859289,
    transparent = 0x00000000,

    bar = {
        -- bg = 0xe61e2326,
        bg = 0xff1e2326,
        border = 0xff2e383c,
    },

    popup = {
        bg = 0xff2e383c,
        border = 0xff9da9a0,
    },

    bg1 = 0xff2e383c,
    bg2 = 0xff374247,

    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
    end,
}
