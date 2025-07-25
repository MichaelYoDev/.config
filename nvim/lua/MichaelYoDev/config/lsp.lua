vim.lsp.enable({
    'bash',
    'css',
    'go',
    'html',
    'java',
    'lua',
    'md',
    'python',
    'rust',
    'ts',
    'typst',
})

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
    return hover({
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.7),
    })
end

vim.diagnostic.config({
    float = { border = "rounded" }
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local buf = ev.buf
        local opts = { buffer = buf, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>lk", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)

        if client.supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })

            vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end, opts)
            vim.keymap.set("i", "<C-n>", "<Down>", opts)
            vim.keymap.set("i", "<C-p>", "<Up>", opts)
            vim.keymap.set("i", "<C-e>", "<Nop>", opts)
        end
    end,
})
