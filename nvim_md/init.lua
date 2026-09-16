-- SET =========================================================================
local o = vim.opt
o.guicursor = ""
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

-- AUTO-SAVE ===================================================================
o.autowriteall = true
local au = vim.api.nvim_create_autocmd
au({ "InsertLeavePre", "TextChanged", "TextChangedP" }, {
    callback = function()
        if vim.bo.modifiable and not vim.bo.readonly then
            vim.cmd("silent! update")
        end
    end,
})

-- PLUGINS =====================================================================
vim.pack.add({
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    -- { src = 'https://github.com/neanias/everforest-nvim',                  name = 'everforest' },
    { src = 'https://github.com/rose-pine/neovim',                name = 'rose-pine' },
})

require('render-markdown').setup({ checkbox = { checked = { scope_highlight = '@markup.strikethrough' } } })
-- require('everforest').setup({ background = 'hard', transparent_background_level = 1 })
vim.cmd.colorscheme('rose-pine')

-- SNIPPETS ====================================================================
local function next_weekday(target)
    -- returns mm/dd of the next weekday (e.g. "mon" becomes "--> 9/8)
    local days = { sun = 1, mon = 2, tue = 3, wed = 4, thu = 5, fri = 6, sat = 7 }
    local today = os.date("*t")
    local today_wd = today.wday
    local diff = (days[target] - today_wd + 7) % 7
    if diff == 0 then diff = 7 end
    local next_time = os.time { year = today.year, month = today.month, day = today.day + diff }
    return os.date("--> %-m/%-d", next_time)
end

local snippet = {
    date  = function() return os.date("%Y-%m-%d") end,
    warn  = "> [!WARNING]\n> ${1}",
    info  = "> [!INFO]\n> ${1}",
    tip   = "> [!TIP]\n> ${1}",
    note  = "> [!NOTE]\n> ${1}",
    link  = "[${1:alt text}](${2:link})",
    img   = "![${1:alt text}](${2:path/to/image.png})",
    table = [[
| ${1:Header 1} | ${2:Header 2} |
| --- | --- |
| ${3:Row 1 Col 1} | ${4:Row 1 Col 2} |
]],

    mon   = function() return next_weekday("mon") end,
    tue   = function() return next_weekday("tue") end,
    wed   = function() return next_weekday("wed") end,
    thu   = function() return next_weekday("thu") end,
    fri   = function() return next_weekday("fri") end,
    sat   = function() return next_weekday("sat") end,
    sun   = function() return next_weekday("sun") end,
    tod   = function() return os.date("--> %m/%d") end,
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

local function markdown2pdf(input)
    if not input or input == "" then
        print("Usage: markdown2pdf(<file.md>)")
        return
    end

    local f = io.open(input, "r")
    if not f then
        print("File not found: " .. input)
        return
    end
    f:close()

    local filename = input:match("([^/]+)%.md$")
    if not filename then
        print("Invalid input file (must end in .md)")
        return
    end

    local home = os.getenv("HOME") or "~"
    local output = home .. "/Downloads/" .. filename .. ".pdf"

    local cmd = string.format('pandoc "%s" -o "%s" -V geometry:margin=1in', input, output)
    local ok = os.execute(cmd)

    if ok == 0 then
        print("PDF saved to " .. output)
    else
        print("Conversion failed")
    end
end

-- KEYMAPS =====================================================================
vim.g.mapleader = " "

local m = vim.keymap.set
m("i", "<C-e>", expand_snippet)
m("n", "<leader>e", vim.cmd.Explore)
m("n", "<leader>c", "0ci[x<C-[>0j", { desc = "check an unfinished checkbox" })
m("n", "<leader>d", "0ci[-<C-[>0j", { desc = "in-progress an unfinished checkbox" })
m("n", "<leader>n", "0i- [ ] ", { desc = "new checkbox" })
m("n", "<leader>s", "1z=", { desc = "replace word with first spelling suggestion" })
vim.keymap.set('n', '<leader>mp', function()
    local input = vim.api.nvim_buf_get_name(0)
    markdown2pdf(input)
end)
m('x', '<leader>p', '"_dP')
m({ 'n', 'v' }, '<leader>d', '"_d')
