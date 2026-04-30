return {
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

    -- -- rosepine dawn
    -- black = 0xfffaf4ed,
    -- white = 0xff575279,
    -- red = 0xffb4637a,
    -- green = 0xff56949f,
    -- blue = 0xff286983,
    -- yellow = 0xffea9d34,
    -- orange = 0xffd7827e,
    -- magenta = 0xff907aa9,
    -- grey = 0xff9893a5,
    -- transparent = 0x00000000,
    --
    -- bar = {
    --     bg = 0xfffaf4ed,
    --     border = 0xfffffaf3,
    -- },
    --
    -- popup = {
    --     bg = 0xfffffaf3,
    --     border = 0xff9893a5,
    -- },
    --
    -- bg1 = 0xfff2e9e1,
    -- bg2 = 0xffdfdad9,

    -- -- everforest light hard
    -- black = 0xfffffbef, -- white
    -- white = 0xff5c6a72, -- black
    -- red = 0xfff85552,
    -- green = 0xff8da101,
    -- blue = 0xff3a94c5,
    -- yellow = 0xffdfa000,
    -- orange = 0xfff57d26,
    -- magenta = 0xffdf69ba,
    -- grey = 0xff939f91, -- grey 1
    -- transparent = 0x00000000,
    --
    -- bar = {
    --     bg = 0xffe8e5d5, -- bg dim
    --     border = 0xfff8f5e4, -- bg 1
    -- },
    --
    -- popup = {
    --     bg = 0xfff8f534, -- bg 1
    --     border = 0xff829181, -- grey 2
    -- },
    --
    -- bg1 = 0xfff8f5e4, -- bg 1
    -- bg2 = 0xffbec5b2, -- bg 5

    -- -- everforest dark hard
    -- black = 0xff272e33, -- bg 0
    -- white = 0xffd3c6aa,
    -- red = 0xffe67e80,
    -- green = 0xffa7c080,
    -- blue = 0xff7fbbb3,
    -- yellow = 0xffdbbc7f,
    -- orange = 0xffe69875,
    -- magenta = 0xffd699b6,
    -- grey = 0xff859289, -- grey 1
    -- transparent = 0x00000000,
    --
    -- bar = {
    --     -- bg = 0xe61e2326,
    --     bg = 0xff1e2326, -- bg dim
    --     border = 0xff2e383c, -- bg 1
    -- },
    --
    -- popup = {
    --     bg = 0xff2e383c, -- bg 1
    --     border = 0xff9da9a0, -- grey 2
    -- },
    --
    -- bg1 = 0xff2e383c, -- bg 1
    -- bg2 = 0xff374247, -- bg 2

    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
    end,
}
