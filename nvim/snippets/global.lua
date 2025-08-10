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

-- return {
--   { trigger = "date", expansion = os.date("%Y-%m-%d") },
--   { trigger = "gh", expansion = "github.com/MichaelYoDev" },
--   { trigger = "shebang", expansion = "#!/usr/bin/env bash" },
--   { trigger = "time", expansion = os.date("%H:%M") },
--   {
--     trigger = "sep",
--     expansion = function()
--       local col = vim.fn.virtcol(".")
--       return string.rep("=", 80 - col + 1)
--     end,
--   },
-- }
