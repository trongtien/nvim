require "nvchad.options"

-- vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.scrolloff = 10

-- Performance optimizations for large files (especially Rust)
vim.opt.updatetime = 250  -- Faster completion and diagnostics
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 1500  -- Longer redraw time for complex syntax
vim.opt.lazyredraw = false  -- Don't skip redraws for better responsiveness

-- Better syntax highlighting performance
vim.opt.synmaxcol = 300  -- Don't highlight lines longer than 300 columns

--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
