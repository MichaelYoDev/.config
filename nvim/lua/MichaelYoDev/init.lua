require("MichaelYoDev.set")
require("MichaelYoDev.remap")
require("MichaelYoDev.lazy_init")
require("MichaelYoDev.typst")
require("MichaelYoDev.video")

local augroup = vim.api.nvim_create_augroup
local MichaelYoDevGroup= augroup('MichaelYoDev', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = MichaelYoDevGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('BufEnter', {
    group = MichaelYoDevGroup,
    callback = function()
        vim.cmd.colorscheme("rose-pine")
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
