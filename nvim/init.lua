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
o.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }

-- leader
vim.g.mapleader = " "

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

-- PLUGINS =====================================================================
vim.pack.add({
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/stevearc/oil.nvim" },
})

local function pack_clean()
    local active, unused = {}, {}
    for _, p in ipairs(vim.pack.get()) do active[p.spec.name] = p.active end
    for _, p in ipairs(vim.pack.get()) do if not active[p.spec.name] then unused[#unused + 1] = p.spec.name end end
    if #unused == 0 then return print("No unused plugins.") end
    if vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2) == 1 then vim.pack.del(unused) end
end

local function show_plugins()
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
        border = "rounded",
    })

    for _, key in ipairs({ "q", "<Esc>" }) do
        vim.keymap.set("n", key, function() vim.api.nvim_win_close(win, true) end, { buffer = buf, silent = true })
    end
end

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

require("mason").setup()

require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.pick").setup()

require("oil").setup({ view_options = { show_hidden = true }, columns = {} })

require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

-- KEYMAPS =====================================================================
local m = vim.keymap.set

m("n", "<leader>e", "<CMD>Oil<CR>")
m("n", "<leader>f", "<CMD>Pick files<CR>")
m("n", "<leader>h", "<CMD>Pick help<CR>")
m("n", "<leader>lf", function()
    vim.cmd([[%s/\s\+$//e]])
    vim.lsp.buf.format()
end)
m("n", "<leader>m", "<CMD>Mason<CR>")
m("n", "<leader>o", "<CMD>update<CR><CMD>source<CR>")
m("n", "<leader>pc", pack_clean)
m("n", "<leader>pg", show_plugins, { desc = "Show installed plugins" })
m("n", "<leader>pu", vim.pack.update)
m("n", "<leader>q", "<CMD>quit<CR>")
m("n", "<leader>s", [[<CMD>%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
m("n", "<leader>w", "<CMD>write<CR>")
m("n", "<leader>x", "<CMD>!chmod +x %<CR>", { silent = true })
m("n", '<leader>v', ':e $MYVIMRC<CR>')

m("i", "<C-e>", function() require("luasnip").expand_or_jump(1) end, { silent = true })
m({ "i", "s" }, "<C-K>", function() require("luasnip").jump(-1) end, { silent = true })
