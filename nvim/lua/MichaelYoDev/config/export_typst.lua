local export_types = { "pdf", "png", "svg", "html" }

local function export(target)
    if not vim.tbl_contains(export_types, target) then
        print("Unsupported filetype. Use 'pdf', 'png', 'svg', or 'html'.")
        return
    end

    if vim.bo.filetype ~= "typst" then
        print("Current buffer is not a typst file")
        return
    end

    local current_file = vim.fn.expand("%:p")
    local cmd = "typst compile --format " .. target .. " " .. current_file
    print("Running: " .. cmd)
    local result = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error

    if exit_code ~= 0 then
        print("Typst compilation failed: " .. result)
    else
        print("Successfully exported to " .. target)
    end
end

vim.api.nvim_create_user_command("Export", function(args)
    local arg = args.args ~= "" and args.args or "pdf"
    export(arg)
end, {
    nargs = "?",
    complete = function()
        return export_types
    end,
})

-- MiniPick version of export format picker
local function export_picker()
    if vim.bo.filetype ~= "typst" then
        print("Current buffer is not a typst file")
        return
    end

    local win_config = function()
        local height = math.floor(0.2 * vim.o.lines)
        local width = math.floor(0.2 * vim.o.columns)
        return {
            anchor = 'NW',
            height = height,
            width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
        }
    end

    require("mini.pick").start({
        source = {
            name = "Export formats",
            items = export_types,
            choose = function(item)
                export(item)
            end,
        },
        prompt = "Export as:",
        window = {
            config = win_config,
        },
    })
end

vim.api.nvim_create_user_command("ExportPicker", export_picker, {})
