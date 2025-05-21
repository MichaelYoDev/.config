local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    -- math modes
    s({ trig = "mt", snippetType = "autosnippet" },
        fmta("$<>$ ", { i(1) })
    ),
    s({ trig = "t" },
        fmta("^(<>) ", { i(1) })
    ),

    s({ trig = "rt", snippetType = "autosnippet" },
        fmta("^(<>) ", { i(1) })
    ),

    s({ trig = "mmt", snippetType = "autosnippet" },
        fmta("$ <> $ ", { i(1) })
    ),

    s({ trig = "iff", snippetType = "autosnippet" },
        fmt("<==>", {})
    ),
    s({ trig = "impl" },
        fmt("==>", {})
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
          Lorem
        ]

        #par(first-line-indent: 3em)[
          Nulla id nostrud in ullamco magna dolor laboris. Id ipsum ut Lorem fugiat est minim aliquip voluptate duis cillum pariatur. Anim dolor nulla exercitation sint excepteur proident labore dolor.
        ]

        <>
        ]], { i(1) })
    ),

    s({ trig = "ltr" },
        fmta([[
        #set page(
          "us-letter",
          margin: (x: 1in, y: 1in),
        )

        #set text(size: 12pt)

        <>
        ]], { i(1) })
    ),
}
