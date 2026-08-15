local colors = require("colors")

local function build_bar()
    return {
        topmost = "window",
        height = 34,
        color = colors.bar.bg,
        padding_right = 2,
        padding_left = 2,
        -- blur_radius = 15,
        shadow = true,
        sticky = true,
    }
end

sbar.bar(build_bar())

return {
    apply = function()
        sbar.bar(build_bar())
    end,
}
