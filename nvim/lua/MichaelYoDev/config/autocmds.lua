local api = vim.api
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd

local trimGroup = augroup("TrimWhitespace", {})
local yankGroup = augroup("HighlightYank", {})

-- Highlight on yank
autocmd("TextYankPost", {
  group = yankGroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ h1group = "IncSearch", timeout = 60 })
  end,
})

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  group = trimGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
