return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
                git_ignored = false,
                custom = {},
                exclude = {},
            },
            view = {
                float = {
                    enable = false,
                },
            },
            renderer = {
                icons = {
                    show = {
                        file = false,
                        folder = true,
                        folder_arrow = false,
                        git = false,
                    },
                    glyphs = {
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = ">",
                            open = "v",
                        },
                    },
                },
            },
        })

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })
        vim.keymap.set("n", "<leader>fe", function()
            local api = require("nvim-tree.api")
            local bufname = vim.fn.bufname()
            if bufname == "" or vim.fn.isdirectory(bufname) ~= 0 then
                if not api.tree.is_visible() then
                    api.tree.open()
                else
                    api.tree.focus()
                end
                return
            end
            if not api.tree.is_visible() then
                api.tree.open()
            else
                api.tree.focus()
            end
            api.tree.find_file(vim.fn.fnamemodify(bufname, ":."))
        end, { desc = "Focus nvim-tree on current file" })
    end,
}
