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
        { trigger = "link", body = "[${1:alt text}](${2:link})" },
        { trigger = "img",  body = "![${1:alt text}](${2:path/to/image.png})" },
        {
            trigger = "table",
            body = [[
| ${1:Header 1} | ${2:Header 2} |
| --- | --- |
| ${3:Row 1 Col 1} | ${4:Row 1 Col 2} |
]],
        },
    },
    typst = {
        {
            trigger = "mla",
            body = [[
#set page(
    paper: "us-letter",
    header: context align(right)[Oliveira #counter(page).get().first()],
    margin: 1in,
)

#set text(
    size: 12pt,
    font: "Times New Roman",
)

#set par(
    first-line-indent: (amount: 0.5in, all: true),
    justify: false,
    leading: 1.625em,
    spacing: 1.625em,
)

#align(left, stack(
    dir: ttb,
    spacing: 2em,
    "Michael Oliveira",
    "Teacher McTeacherson",
    "Class 123",
    datetime.today().display("[day] [month repr:long] [year repr:full] "),
))

#align(center)[${1}]

${2}
]],
        },
    },
}

function M.expand()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local trigger = line:sub(1, col):match("(%w+)$")
    if not trigger then return end

    local snips = vim.deepcopy(global_snippets)
    local ft = vim.bo.filetype
    if ft and ft_snippets[ft] then
        vim.list_extend(snips, ft_snippets[ft])
    end

    for _, snip in ipairs(snips) do
        if snip.trigger == trigger then
            local start_col = col - #trigger
            vim.api.nvim_buf_set_text(0, row - 1, start_col, row - 1, col, { "" })
            local expansion = type(snip.body) == "function" and snip.body() or snip.body
            vim.snippet.expand(expansion)
            return
        end
    end
end

return M
