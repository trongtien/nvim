return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local nvimtree_setup, nvimtree = pcall(require, "nvim-tree")
        if not nvimtree_setup then
            return
        end
        -- change color of arrows in tree
        vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

        nvimtree.setup({
            renderer = {
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = ">>", -- closed folder icon
                            arrow_open = ">>",   -- open folder icon
                        },
                    },
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                dotfiles = false,
            },
            git = {
                ignore = false, -- show .gitignored files.
            },
        })

        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
}
