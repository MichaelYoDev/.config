---@diagnostic disable: undefined-global

return {
    s("date", t(os.date("%Y-%m-%d"))),
    s("gh", t("github.com/MichaelYoDev")),
    s("shebang", t("#!/usr/bin/env bash")),
    s("time", t(os.date("%H:%M"))),

    s("sep", f(function()
        return string.rep("=", 80 - vim.fn.virtcol('.') + 1)
    end))
}
