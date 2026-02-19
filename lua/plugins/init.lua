return {
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, conf)
            conf.defaults.mappings.i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<Esc>"] = require("telescope.actions").close,
            }
            return conf
        end,
    },
    {
        "github/copilot.vim",
        lazy = false,
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""

            -- Key mappings for Copilot
            vim.keymap.set('i', '<Tab>', 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false,
                desc = 'Copilot accept suggestion'
            })
            vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', { desc = 'Copilot next suggestion' })
            vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', { desc = 'Copilot previous suggestion' })
            vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-dismiss)', { desc = 'Copilot dismiss suggestion' })
        end,
    },
}
