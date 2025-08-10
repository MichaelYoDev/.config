---@diagnostic disable: undefined-global

return {
    -- math modes
    s({ trig = "mt", snippetType = "autosnippet" },
        fmta("$<>$ ", { i(1) })
    ),

    s({ trig = "([^%s]+)t", regTrig = true },
        fmta("(<>)^(<>) ", {
            f(function(_, s) return s.captures[1] end),
            i(1)
        })
    ),

    s({ trig = "mmt", snippetType = "autosnippet" },
        fmta("$ <> $ ", { i(1) })
    ),

    s({ trig = "mla" },
        fmta([[
        Michael Oliveira

        Teacher McTeacherson

        Class 123

        #let today = datetime.today()
        #today.display(
            "[year repr:full] [month repr:short] [day]"
        )

        #align(center)[
            <>
        ]

        #par(first-line-indent: 3em)[
            <>
        ]


        ]], { i(1), i(2) })
    ),

    s({ trig = "ltr" },
        fmta([[
        #set page(
            "us-letter",
            margin: auto,
        )

        #set text(
            size: 12pt,
            font: "Times Newer Roman"
            top-edge: 1em,
            bottom-edge: -0.2em
        )

        #set par(
            leading: 1em
        )

        <>
        ]], { i(1) })
    ),

    s({ trig = "par" },
        fmta([[
        #par(first-line-indent: 3em)[
            <>
        ]
        ]], { i(1) })
    ),
}
