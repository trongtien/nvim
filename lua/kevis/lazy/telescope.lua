return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        { "nvim-lua/plenary.nvim",                    rocks = { enabled = false } },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    config = function()
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                prompt_prefix = "  ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                file_ignore_patterns = {
                    "node_modules",
                    ".git",
                    "dist",
                    "build",
                    "target",
                    "__pycache__",
                    "%.o",
                    "%.a",
                    "%.out",
                    "%.class",
                    "%.pdf",
                    "%.mkv",
                    "%.mp4",
                    "%.zip",
                },
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
            },
            pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                    hidden = true,
                },
            },
        })
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', function()
            telescope.load_extension('fzf')
            builtin.find_files({ no_ignore = true, hidden = true })
        end, { desc = "Find all files (including hidden/ignored)" })

        vim.keymap.set('n', '<leader>fg', function()
            telescope.load_extension('fzf')
            builtin.git_files()
        end, { desc = "Git files" })

        vim.keymap.set('n', '<leader>sg', function()
            telescope.load_extension('fzf')
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>Sg', function()
            telescope.load_extension('fzf')
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<C-f>', function()
            telescope.load_extension('fzf')
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
