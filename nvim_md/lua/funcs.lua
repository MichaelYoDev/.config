local M = {}

function M.pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

function M.pack_get()
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
    })

    for _, key in ipairs({ "q", "<Esc>" }) do
        vim.keymap.set("n", key, function() vim.api.nvim_win_close(win, true) end, { buffer = buf, silent = true })
    end
end

return M
