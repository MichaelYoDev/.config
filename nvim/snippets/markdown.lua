---@diagnostic disable: undefined-global

return {

    -- admonitions
    s({ trig = "warn" }, fmt("> [!WARNING]\n> {}", { i(1) })),
    s({ trig = "info" }, fmt("> [!INFO]\n> {}", { i(1) })),
    s({ trig = "tip" }, fmt("> [!TIP]\n> {}", { i(1) })),
    s({ trig = "hint" }, fmt("> [!HINT]\n> {}", { i(1) })),
    s({ trig = "note" }, fmt("> [!NOTE]\n> {}", { i(1) })),
    s({ trig = "danger" }, fmt("> [!DANGER]\n> {}", { i(1) })),

    -- link
    s({ trig = "link" },
        fmta([[[<>](<>)]], { i(1), i(2) })
    ),

    -- image
    s({ trig = "img" },
        fmt([[![{}]({})]], { i(1), i(2) })
    ),

    -- table
    s({ trig = "table" },
        fmta([[
        | <> | <> |
        | :----: | :----: |
        | | |
        | | |
        ]], { i(1), i(2) })
    ),
}

-- return {
--   { trigger = "warn", expansion = "> [!WARNING]\n> ${1}" },
--   { trigger = "info", expansion = "> [!INFO]\n> ${1}" },
--   { trigger = "tip", expansion = "> [!TIP]\n> ${1}" },
--   { trigger = "hint", expansion = "> [!HINT]\n> ${1}" },
--   { trigger = "note", expansion = "> [!NOTE]\n> ${1}" },
--   { trigger = "danger", expansion = "> [!DANGER]\n> ${1}" },
--
--   { trigger = "link", expansion = "[${1}](${2})" },
--
--   { trigger = "img", expansion = "![${1}](${2})" },
--
--   { trigger = "table", expansion =
--     [[
-- | ${1} | ${2} |
-- | :----: | :----: |
-- | ${3} | ${4} |
-- | ${5} | ${6} |
-- ]]
--   },
-- }
