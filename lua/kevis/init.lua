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
        pcall(vim.cmd.colorscheme, "rose-pine-moon")
    end
})


autocmd('LspAttach', {
    group = KevisGroup,
    callback = function(e)
        local builtin = require "telescope.builtin"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })

        -- list all methods in a file
        -- working with go confirmed, don't know about other, keep changing as necessary
        vim.keymap.set("n", "<leader>fm", function()
            local filetype = vim.bo.filetype
            local symbols_map = {
                python = "function",
                javascript = "function",
                typescript = "function",
                lua = "function",
                go = { "method", "struct", "interface" },
            }
            local symbols = symbols_map[filetype] or "function"
            require("fzf-lua").lsp_document_symbols({ symbols = symbols })
        end, {})

        vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { buffer = 0 })
        vim.keymap.set("n", "<leader>ww", function()
            builtin.diagnostics { root_dir = true }
        end, { buffer = 0 })
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
