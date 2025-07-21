local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 40,
	color = colors.bar.bg,
	padding_right = 2,
	padding_left = 2,
	-- blur_radius = 15,
    blur_radius = 0,
	-- shadow = true,
    shadow = false,
	sticky = true,
})
