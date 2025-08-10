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
