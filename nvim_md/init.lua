-- SET =========================================================================
local o = vim.opt
o.guicursor = ""
o.number = true
o.relativenumber = true
o.scrolloff = 8
o.signcolumn = "yes"
o.termguicolors = true
o.winborder = "rounded"

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.clipboard = "unnamedplus"
o.swapfile = false
o.undofile = true

o.ignorecase = true
o.smartcase = true

-- MARKDOWN ====================================================================
vim.keymap.set({ "n", "x", "v" }, "j", "gj")
vim.keymap.set({ "n", "x", "v" }, "k", "gk")

o.formatoptions:append("t")
o.linebreak = true
o.spell = true
o.spelllang = "en_us"
o.wrap = true
o.wrapmargin = 0

-- PLUGINS =====================================================================
vim.pack.add({
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
})

require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

local function pack_get()
    local buf = vim.api.nvim_create_buf(false, true)
    local plugins = vim.tbl_map(
        function(p) return (p.spec.name or "unknown") .. " [" .. (p.active and "active" or "inactive") .. "]" end,
        vim.pack.get()
    )

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Installed plugins:", unpack(plugins) })
    vim.bo[buf].modifiable = false

    local width, height = 50, math.min(#plugins + 1, 15)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
    })

    for _, key in ipairs({ "q", "<Esc>" }) do
        vim.keymap.set("n", key, function() vim.api.nvim_win_close(win, true) end, { buffer = buf, silent = true })
    end
end

-- SNIPPETS ====================================================================
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
}

local function expand_snippet()
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

-- KEYMAPS =====================================================================
vim.g.mapleader = " "

local m = vim.keymap.set
m("i", "<C-e>", expand_snippet)
m("n", "<leader>pg", pack_get)
m("n", "<leader>pu", vim.pack.update)
