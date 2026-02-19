require "nvchad.autocmds"

-- Auto-save configuration
local auto_save_group = vim.api.nvim_create_augroup('AutoSave', { clear = true })

-- Auto-save on focus lost and when leaving insert mode
vim.api.nvim_create_autocmd({ 'FocusLost', 'InsertLeave', 'TextChanged' }, {
    desc = 'Auto-save file on changes',
    group = auto_save_group,
    pattern = '*',
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand('%') ~= '' and vim.bo.buftype == '' then
            vim.cmd('silent! write')
        end
    end,
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Format code before saving',
    group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true }),
    pattern = '*',
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
