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

-- Rust-specific optimizations
vim.api.nvim_create_autocmd('FileType', {
    desc = 'Optimize settings for Rust files',
    group = vim.api.nvim_create_augroup('RustOptimize', { clear = true }),
    pattern = 'rust',
    callback = function()
        -- Reduce updatetime for Rust files for faster diagnostics
        vim.opt_local.updatetime = 500  -- Increased from 300ms to reduce frequent checks
        -- Disable some slow features for better performance
        vim.b.large_buf = vim.api.nvim_buf_line_count(0) > 3000  -- Lower threshold
        if vim.b.large_buf then
            vim.opt_local.foldmethod = 'manual'
            vim.opt_local.spell = false
            vim.opt_local.relativenumber = false
        end
    end,
})

-- Manual Rust check command (use :RustCheck when needed)
vim.api.nvim_create_user_command('RustCheck', function()
    vim.cmd('!cargo check')
end, { desc = 'Run cargo check manually' })

-- Manual Rust clippy command (use :RustClippy when needed)
vim.api.nvim_create_user_command('RustClippy', function()
    vim.cmd('!cargo clippy')
end, { desc = 'Run cargo clippy manually' })
