-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local pos = vim.api.nvim_win_get_cursor(0)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local modified = false

        for i, line in ipairs(lines) do
            local trimmed = line:gsub("%s+$", "")
            if trimmed ~= line then
                lines[i] = trimmed
                modified = true
            end
        end

        if modified then
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        end

        vim.api.nvim_win_set_cursor(0, pos)
    end,
})

