-- Enable LSP for specified languages
vim.lsp.enable({
    'bash', 'css', 'go', 'html', 'java', 'lua', 'md', 'python', 'rust', 'ts', 'typst',
})

-- Configure LSP hover with custom styling
vim.lsp.buf.hover = function()
    vim.lsp.buf.hover({
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.7),
    })
end

-- Configure diagnostic display
vim.diagnostic.config({
    float = { border = "rounded" }
})

-- LSP keymaps and completion setup on attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-config", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local buf = ev.buf
        local opts = { buffer = buf, silent = true }

        -- Keymaps for LSP actions
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>lk", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)

        -- Enable completion if supported
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })

            vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, opts)
            vim.keymap.set("i", "<C-n>", "<Down>", opts)
            vim.keymap.set("i", "<C-p>", "<Up>", opts)
        end
    end,
})

-- Manual snippet expansion with <C-e>
vim.keymap.set("i", "<C-e>", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local before_cursor = line:sub(1, col)
    local trigger = before_cursor:match("(%S+)$")
    if not trigger then return end

    for _, s in ipairs(require("MichaelYoDev.config.snippets").get_snippet_items()) do
        if s.label == trigger then
            local start_col = col - #trigger
            vim.api.nvim_buf_set_text(bufnr, row - 1, start_col, row - 1, col, { "" })
            vim.snippet.expand(s.insertText)
            break
        end
    end
end, { silent = true, desc = "Expand built-in snippet" })

-- Auto-expand snippets on completion
vim.api.nvim_create_autocmd("CompleteDone", {
    group = vim.api.nvim_create_augroup("builtin-snippets", { clear = true }),
    desc = "Expand built-in snippets",
    callback = function()
        local item = vim.v.completed_item or {}
        local lsp_data = item.user_data and item.user_data.nvim and item.user_data.nvim.lsp
        if not lsp_data then return end

        local complete_info = lsp_data.completion_item
        if not complete_info or complete_info.insertTextFormat ~= vim.lsp.protocol.InsertTextFormat.Snippet then return end

        local text = complete_info.insertText or (complete_info.textEdit and complete_info.textEdit.newText)
        if text then
            vim.snippet.expand(text)
        end
    end
})
