-- SET =========================================================================
local o = vim.opt

o.guicursor = ""
o.number = true
o.relativenumber = true
o.scrolloff = 8
o.signcolumn = "yes"
o.termguicolors = true
o.winborder = "rounded"
o.wrap = false

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.clipboard = "unnamedplus"
o.swapfile = false
o.undofile = true

o.ignorecase = true
o.smartcase = true

o.completeopt = { "menu", "fuzzy", "menuone", "noinsert", "popup" }

-- LSP =========================================================================
vim.lsp.enable({ "bashls", "cssls", "gopls", "html", "jdtls", "lua_ls", "markdown_oxide", "pylsp", "rust_analyzer",
    "tinymist", "ts_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-config", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- SNIPPETS ====================================================================
local snippets = require("snippets")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.omnifunc = "v:lua.require'snippets'.omnifunc"
    end,
})

-- PLUGINS =====================================================================
vim.pack.add({
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/stevearc/oil.nvim" },
})

require("mason").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("oil").setup({ view_options = { show_hidden = true }, columns = {} })
require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

-- KEYMAPS =====================================================================
vim.g.mapleader = " "
local m = vim.keymap.set
local funcs = require("funcs")

m("i", "<C-e>", snippets.expand_snippet)
m("n", "<leader>e", "<CMD>Oil<CR>")
m("n", "<leader>f", "<CMD>Pick files<CR>")
m("n", "<leader>h", "<CMD>Pick help<CR>")
m("n", "<leader>lf", function()
    vim.cmd([[%s/\s\+$//e]])
    vim.lsp.buf.format()
end)
m("n", "<leader>o", "<CMD>update<CR><CMD>source<CR>")
m("n", "<leader>pc", funcs.pack_clean)
m("n", "<leader>pg", funcs.pack_get)
m("n", "<leader>pu", vim.pack.update)
m("n", "<leader>s", [[<CMD>%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
m("n", "<leader>w", "<CMD>write<CR>")
m("n", "<leader>x", "<CMD>!chmod +x %<CR>", { silent = true })
m("n", "<leader>v", ':e $MYVIMRC<CR>')
