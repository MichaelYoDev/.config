local M = {}

-- Global snippets (apply to all filetypes)
local global_snippets = {
    { trigger = 'shebang', body = '#!/usr/bin/env bash' },
    { trigger = 'date',    body = '${TM_LINE_NUMBER}/${TM_FILENAME}' }
}

-- Filetype-specific snippets
local snippets_by_filetype = {
    markdown = {
        { trigger = 'warn',   body = '> [!WARNING]\n> ${1:text}' },
        { trigger = 'info',   body = '> [!INFO]\n> ${1:text}' },
        { trigger = 'tip',    body = '> [!TIP]\n> ${1:text}' },
        { trigger = 'hint',   body = '> [!HINT]\n> ${1:text}' },
        { trigger = 'note',   body = '> [!NOTE]\n> ${1:text}' },
        { trigger = 'danger', body = '> [!DANGER]\n> ${1:text}' },
        { trigger = 'link',   body = '[${1:text}](${2:url})' },
        { trigger = 'img',    body = '![${1:alt}](${2:src})' },
        {
            trigger = 'table',
            body = [[
| ${1:Header1} | ${2:Header2} |
| :---: | :---: |
| ${3:Row1} | ${4:Row1} |
| ${5:Row2} | ${6:Row2} |
]]
        },
    },

    typst = {
        {
            trigger = 'mla',
            body = [[
Michael Oliveira

Teacher McTeacherson

Class 123

#set today = datetime.today()
#today.display("[year repr:full] [month repr:short] [day]")

#align(center)[
    Lorem
]

#par(first-line-indent: 3em)[
    $0
]
]]
        },
        {
            trigger = 'ltr',
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

$0
]]
        },
        {
            trigger = 'par',
            body = [[
#par(first-line-indent: 3em)[
    $0
]
]]
        },
    }
}

-- Get snippets for current buffer's filetype
local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(global_snippets)
    if ft and snippets_by_filetype[ft] then
        vim.list_extend(snips, snippets_by_filetype[ft])
    end
    return snips
end

-- Provide snippets as completion items
M.get_snippet_items = function()
    return vim.tbl_map(function(s)
        return {
            label = s.trigger,
            insertText = s.body,
            kind = vim.lsp.protocol.CompletionItemKind.Snippet,
            insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
        }
    end, get_buf_snips())
end

-- Setup snippet completion
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("snippet-completion", { clear = true }),
    callback = function()
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.lsp.omnifunc = function(findstart, base)
            if findstart == 1 then
                local line = vim.fn.getline(".")
                local pos = vim.fn.col(".") - 1
                return vim.fn.match(line:sub(1, pos), [[\k*$]])
            else
                return M.get_snippet_items()
            end
        end
    end
})

return M
