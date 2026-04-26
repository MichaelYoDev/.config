local colors = require("colors")

sbar.bar({
    topmost = "window",
    position = "left",
    height = 40,
    color = colors.bar.bg,
    padding_right = 2,
    padding_left = 2,
    blur_radius = 15,
    shadow = true,
    sticky = true,
    -- x_offset = 5,
    y_offset = 4,
    margin = 4,
    border_color = colors.bg2,
    border_width = 2,
    corner_radius = 13,

})
