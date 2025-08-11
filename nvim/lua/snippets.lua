local M = {}

local global_snippets = {
    { trigger = "date",    body = os.date("%Y-%m-%d") },
    { trigger = "gh",      body = "github.com/MichaelYoDev" },
    { trigger = "shebang", body = "#!/usr/bin/env bash" },
    { trigger = "time",    body = os.date("%H:%M") },
    {
        trigger = "sep",
        body = function()
            local col = vim.fn.virtcol(".")
            return string.rep("=", 80 - col + 1)
        end,
    },
}

local ft_snippets = {
    markdown = {
        { trigger = "warn", body = "> [!WARNING]\n> ${1}" },
        { trigger = "info", body = "> [!INFO]\n> ${1}" },
        { trigger = "tip",  body = "> [!TIP]\n> ${1}" },
        { trigger = "note", body = "> [!NOTE]\n> ${1}" },
        { trigger = "link", body = "[${1}](${2})" },
    },
    typst = {
        {
            trigger = "mla",
            body = [[
Michael Oliveira

Teacher McTeacherson

Class 123

#let today = datetime.today()
#today.display(
    "[year repr:full] [month repr:short] [day]"
)

#align(center)[
    ${1}
]

#par(first-line-indent: 3em)[
    ${2}
]
]],
        },
        {
            trigger = "ltr",
            body = [[
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

${1}
]],
        },
        {
            trigger = "par",
            body = [[
#par(first-line-indent: 3em)[
    ${1}
]
]],
        },
    },
}

local function get_buf_snippets()
    local ft = vim.bo.filetype
    local snips = vim.deepcopy(global_snippets)

    if ft and ft_snippets[ft] then
        vim.list_extend(snips, ft_snippets[ft])
    end

    return snips
end

function M.omnifunc(findstart, base)
    local snippets = get_buf_snippets()

    if findstart == 1 then
        local line = vim.fn.getline(".")
        local col = vim.fn.col(".") - 1
        local start = col
        while start > 0 and line:sub(start, start):match("[%w_]") do
            start = start - 1
        end
        return start
    else
        local matches = {}
        for _, snip in ipairs(snippets) do
            if snip.trigger:match("^" .. vim.pesc(base)) then
                table.insert(matches, snip.trigger)
            end
        end
        return matches
    end
end

function M.expand_snippet()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local before_cursor = line:sub(1, col)
    local trigger = before_cursor:match("(%w+)$")
    if not trigger then return end

    local snippets = get_buf_snippets()
    for _, snip in ipairs(snippets) do
        if snip.trigger == trigger then
            local start_col = col - #trigger
            vim.api.nvim_buf_set_text(0, row - 1, start_col, row - 1, col, { "" })

            local expansion = snip.body
            if type(expansion) == "function" then
                expansion = expansion()
            end

            vim.snippet.expand(expansion)
            return
        end
    end
end

return M
