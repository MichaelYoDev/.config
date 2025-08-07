-- SET =========================================================================
local o = vim.opt

-- ui
o.guicursor = ""
o.number = true
o.relativenumber = true
o.scrolloff = 8
o.signcolumn = "yes"
o.termguicolors = true
o.winborder = "rounded"
o.wrap = false

-- indent
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

-- files
o.clipboard = "unnamedplus"
o.swapfile = false
o.undofile = true

-- search
o.ignorecase = true
o.smartcase = true

-- completion
o.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup", "noselect" }

-- leader
vim.g.mapleader = " "

-- KEYMAPS =====================================================================
local m = vim.keymap.set

m("n", "<leader>e", "<CMD>Oil<CR>")
m("n", "<leader>f", "<CMD>Pick files<CR>")
m("n", "<leader>h", "<CMD>Pick help<CR>")
m("n", "<leader>lf", vim.lsp.buf.format)
m("n", "<leader>m", "<CMD>Mason<CR>")
m("n", "<leader>o", "<CMD>update<CR><CMD>source<CR>")
m("n", "<leader>s", [[<CMD>%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
m("n", "<leader>te", "<CMD>LspTinymistExportPdf<CR>")
m("n", "<leader>tp", "<CMD>TypstPreview<CR>")
m("n", "<leader>u", vim.pack.update)
m("n", "<leader>w", "<CMD>write<CR>")
m("n", "<leader>x", "<CMD>!chmod +x %<CR>", { silent = true })

-- AUTOCOMMANDS ================================================================
local aucmd = vim.api.nvim_create_autocmd
local augrp = vim.api.nvim_create_augroup

aucmd("TextYankPost", {
    group = augrp("HighlightYank", {}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
    end,
})

aucmd("BufWritePre", {
    group = augrp("TrimWhitespace", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- LSP =========================================================================
vim.lsp.enable({
    "bashls",
    "cssls",
    "gopls",
    "html",
    "jdtls",
    "lua_ls",
    "markdown_oxide",
    "pylsp",
    "rust_analyzer",
    "ts_ls",
    "tinymist",
})

aucmd("LspAttach", {
    group = augrp("lsp-config", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
})

vim.lsp.config("tinymist", {
    capabilities = capabilities,
    settings = {
        formatterMode = "typstyle",
        formatterIndentSize = 4,
        exportPdf = "onType",
    },
})

-- PLUGINS =====================================================================
vim.pack.add({
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/xiyaowong/transparent.nvim" },
})

require("mason").setup()

require("oil").setup({
    view_options = { show_hidden = true },
})

require("mini.icons").setup()
require("mini.indentscope").setup({
    symbol = "▏",
    options = { try_as_border = true },
    delay = 0,
    draw = { animation = require("mini.indentscope").gen_animation.none() },
})
require("mini.pairs").setup()
require("mini.pick").setup()

require("rose-pine").setup({
    styles = { transparency = true },
})
vim.cmd.colorscheme("rose-pine")
