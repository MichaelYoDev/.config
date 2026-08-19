local M = {}

function M.list()
    local plugins = vim.pack.get()
    if #plugins == 0 then
        vim.notify('No plugins installed', vim.log.levels.INFO)
        return
    end

    local lines = { 'Installed plugins:', '' }
    for _, p in ipairs(plugins) do
        local status = p.active and '[active]' or '[inactive]'
        local update = p.rev_to and ' (update available)' or ''
        table.insert(lines, ('  %s %s%s'):format(status, p.spec.name, update))
        table.insert(lines, ('    src: %s'):format(p.spec.src))
        table.insert(lines, ('    rev: %s'):format(p.rev or 'unknown'))
        table.insert(lines, '')
    end

    vim.cmd('enew')
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'wipe'
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.bo.modifiable = false
    vim.api.nvim_buf_set_name(0, 'pluginStash')
end

function M.update_all()
    vim.pack.update()
end

function M.delete()
    local inactive = vim.tbl_filter(function(p)
        return not p.active
    end, vim.pack.get())

    if #inactive == 0 then
        vim.notify('No inactive plugins to remove', vim.log.levels.INFO)
        return
    end

    local names = vim.tbl_map(function(p) return p.spec.name end, inactive)
    vim.ui.select(names, { prompt = 'Remove plugin:' }, function(choice)
        if not choice then return end
        vim.pack.del({ choice })
        vim.notify('Removed: ' .. choice, vim.log.levels.INFO)
    end)
end

return M
