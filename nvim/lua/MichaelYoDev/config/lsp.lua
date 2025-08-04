vim.lsp.enable({ 'bash', 'css', 'go', 'html', 'java', 'lua', 'md', 'python', 'rust', 'ts', 'typst' })

-- LSP keymaps + completion setup
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-config", { clear = true }),
    callback = function(ev)
        local buf = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client.supports_method("textDocument/completion") then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
        end
    end,
})

-- Manual snippet expansion with <C-e>
vim.keymap.set("i", "<C-e>", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local before_cursor = line:sub(1, col)
    local trigger = before_cursor:match("(%S+)$")
    if not trigger then return end

    for _, s in ipairs(require("MichaelYoDev.config.snippets").get_snippet_items()) do
        if s.label == trigger then
            vim.api.nvim_buf_set_text(0, row - 1, col - #trigger, row - 1, col, { "" })
            vim.snippet.expand(s.insertText)
            break
        end
    end
end, { silent = true, desc = "Expand built-in snippet" })

-- Auto-expand snippets from completion
vim.api.nvim_create_autocmd("CompleteDone", {
    group = vim.api.nvim_create_augroup("builtin-snippets", { clear = true }),
    desc = "Expand built-in snippets",
    callback = function()
        local item = vim.v.completed_item or {}
        local user_data = item.user_data or {}
        local nvim_data = user_data.nvim or {}
        local lsp_data = nvim_data.lsp or {}
        local ci = lsp_data.completion_item

        if ci and ci.insertTextFormat == vim.lsp.protocol.InsertTextFormat.Snippet then
            local text = ci.insertText or (ci.textEdit and ci.textEdit.newText)
            if text then
                vim.snippet.expand(text)
            end
        end
    end,
})
