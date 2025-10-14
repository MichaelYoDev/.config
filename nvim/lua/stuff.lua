local M = {}

function M.statuslineContent()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
    local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
    local location      = MiniStatusline.section_location({ trunc_width = 75 })
    local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

    return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
    })
end

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

return M
