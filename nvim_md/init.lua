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

-- SNIPPETS ====================================================================
local snippet = {
    date  = function() return os.date("%Y-%m-%d") end,
    warn  = "> [!WARNING]\n> ${1}",
    info  = "> [!INFO]\n> ${1}",
    tip   = "> [!TIP]\n> ${1}",
    note  = "> [!NOTE]\n> ${1}",
    link  = "[${1}](${2})",
    img   = "![${1:alt text}](${2:path/to/image.png})",
    table = [[
| ${1:Header 1} | ${2:Header 2} |
| --- | --- |
| ${3:Row 1 Col 1} | ${4:Row 1 Col 2} |
]],
}

local function expand_snippet()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local trigger = line:sub(1, col):match("(%w+)$")
    if not trigger then return end

    local snip = snippet[trigger]
    if snip then
        local start_col = col - #trigger
        vim.api.nvim_buf_set_text(0, row - 1, start_col, row - 1, col, { "" })
        local expansion = type(snip) == "function" and snip() or snip
        vim.snippet.expand(expansion)
    end
end

-- KEYMAPS =====================================================================
vim.g.mapleader = " "

local m = vim.keymap.set
m("i", "<C-e>", expand_snippet)
m("n", "<leader>pu", vim.pack.update)
m("n", "<leader>e", ":Ex<CR>")
