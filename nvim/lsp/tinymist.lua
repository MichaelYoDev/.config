---@brief
---
--- https://github.com/Myriad-Dreamin/tinymist
--- An integrated language service for Typst [taɪpst]. You can also call it "微霭" [wēi ǎi] in Chinese.
---
--- Currently some of Tinymist's workspace commands are supported, namely:
--- `LspTinymistExportSvg`, `LspTinymistExportPng`, `LspTinymistExportPdf
--- `LspTinymistExportMarkdown`, `LspTinymistExportText`, `LspTinymistExportQuery`,
--- `LspTinymistExportAnsiHighlight`, `LspTinymistGetServerInfo`,
--- `LspTinymistGetDocumentTrace`, `LspTinymistGetWorkspaceLabels`, and
--- `LspTinymistGetDocumentMetrics`.

---@param command_name string
---@param client vim.lsp.Client
---@param bufnr integer
---@return fun():nil run_tinymist_command, string cmd_name, string cmd_desc
local function create_tinymist_command(command_name, client, bufnr)
    local export_type = command_name:match 'tinymist%.export(%w+)'
    local info_type = command_name:match 'tinymist%.(%w+)'
    if info_type and info_type:match '^get' then
        info_type = info_type:gsub('^get', 'Get')
    end
    local cmd_display = export_type or info_type
    ---@return nil
    local function run_tinymist_command()
        local arguments = { vim.api.nvim_buf_get_name(bufnr) }
        local title_str = export_type and ('Export ' .. cmd_display) or cmd_display
        ---@type lsp.Handler
        local function handler(err, res)
            if err then
                return vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
            end
            if not export_type then
                return vim.notify(vim.inspect(res), vim.log.levels.INFO)
            end
            -- export returns one result per document: a single table, or a list of them
            local items = type(res) == 'table' and (vim.islist(res) and res or { res }) or { res }
            local out = vim.tbl_map(function(item)
                if type(item) ~= 'table' then
                    return tostring(item)
                end
                return item.path or item.data or vim.inspect(item)
            end, items)
            vim.notify(#out > 0 and table.concat(out, '\n') or ('Export ' .. cmd_display .. ' done'),
                vim.log.levels.INFO)
        end
        return client:exec_cmd({
            title = title_str,
            command = command_name,
            arguments = arguments,
        }, { bufnr = bufnr }, handler)
    end
    -- Construct a readable command name/desc
    local cmd_name = export_type and ('TinymistExport' .. cmd_display) or ('Tinymist' .. cmd_display) ---@type string
    local cmd_desc = export_type and ('Export to ' .. cmd_display) or ('Get ' .. cmd_display) ---@type string
    return run_tinymist_command, cmd_name, cmd_desc
end

---@type vim.lsp.Config
return {
    cmd = { 'tinymist' },
    filetypes = { 'typst' },
    settings = { formatterMode = "typstyle", formatterIndentSize = 4 },
    root_markers = { '.git' },
    on_attach = function(client, bufnr)
        for _, command in ipairs {
            'tinymist.exportSvg',
            'tinymist.exportPng',
            'tinymist.exportPdf',
            -- 'tinymist.exportHtml', -- Use typst 0.13
            'tinymist.exportMarkdown',
            'tinymist.exportText',
            'tinymist.exportQuery',
            'tinymist.exportAnsiHighlight',
            'tinymist.getServerInfo',
            'tinymist.getDocumentTrace',
            'tinymist.getWorkspaceLabels',
            'tinymist.getDocumentMetrics',
        } do
            local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Lsp' .. cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
        end
    end,
}
