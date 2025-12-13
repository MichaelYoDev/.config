local M = {}

function M.markdown2pdf(input)
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

function M.BufferTabline()
    vim.api.nvim_set_hl(0, "TablineBuffer", { link = "Normal" })
    local s = ''
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
            local name = vim.fn.fnamemodify(vim.fn.bufname(buf), ":t")
            if buf == vim.api.nvim_get_current_buf() then
                s = s .. '%#TablineBuffer#[' .. name .. '] '
            else
                s = s .. '%#TablineBuffer# ' .. name .. '  '
            end
        end
    end
    return s
end

function M.MyStatusLine()
    local mode_map = {
        n = 'Normal',
        i = 'Insert',
        R = 'Replace',
        v = 'Visual',
        V = 'V-Line',
        [''] = 'V-Block',
        c = 'Command',
        s = 'Select',
        S = 'S-Line',
        [''] = 'S-Block',
        t = 'Terminal',
    }
    local mode = vim.fn.mode()
    local mode_name = mode_map[mode] or mode:upper()

    local filepath = vim.fn.expand('%:~:.')
    if filepath == '' then filepath = '[No Name]' end

    local ft = vim.bo.filetype
    if ft == '' then ft = 'none' end

    local enc = vim.bo.fenc ~= '' and vim.bo.fenc or vim.o.enc
    local fmt = vim.bo.fileformat == 'dos' and 'CRLF' or 'LF'

    local function size()
        local b = vim.fn.getfsize(vim.fn.expand('%:p'))
        if b <= 0 then return '0B' end
        local s = { 'B', 'K', 'M', 'G' }
        local i = 1
        while b >= 1024 and i < 4 do
            b = b / 1024; i = i + 1
        end
        return ('%.1f%s'):format(b, s[i])
    end

    local l, c, tot = vim.fn.line('.'), vim.fn.virtcol('.'), vim.fn.line('$')
    local pct       = tot > 0 and math.floor(l * 100 / tot) or 0

    local left      = (' %s | %s '):format(mode_name, filepath)
    local right     = table.concat({ ft, enc .. '[' .. fmt .. ']', size(), pct .. '%% ' .. tot, l .. ':' .. c }, ' │ ')

    return left .. '%=' .. right .. ' '
end

return M
