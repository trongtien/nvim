require("kevis.set")
require("kevis.remap")
require("kevis.lazy_init")

local augroup = vim.api.nvim_create_augroup
local KevisGroup = augroup('Kevis', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('VimEnter', {
    group = KevisGroup,
    callback = function()
        local bufs = vim.api.nvim_list_bufs()
        if #bufs == 1 and bufs[1] == vim.fn.bufnr('') then
            vim.cmd('bdelete!')
        end
        if #vim.api.nvim_list_wins() == 1 then
            vim.cmd('bdelete!')
        end
    end,
})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = KevisGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('BufEnter', {
    group = KevisGroup,
    callback = function()
        if vim.bo.filetype == "zig" then
            pcall(vim.cmd.colorscheme, "tokyonight-night")
        else
            pcall(vim.cmd.colorscheme, "rose-pine-moon")
        end
    end
})


autocmd('LspAttach', {
    group = KevisGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

        vim.keymap.set("n", "<leader>vda", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.goto_prev() end, opts)
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.sessionoptions = { "buffers", "tabpages", "winsize" }

autocmd('VimLeavePre', {
    group = KevisGroup,
    pattern = '*',
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].modified then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end,
})

