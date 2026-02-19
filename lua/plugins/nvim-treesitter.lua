return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "vim",
            "lua",
            "rust",
            "markdown",
            "vimdoc",
            "markdown_inline",
            "python",
            "cpp",
            "make",
            "dockerfile",
            "html",
            "css",
            "go",
            "javascript",
            "typescript",
            "tsx",
            "jsx",
            "vue",
            "json",
            "yaml"
        },
        auto_install = true,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "ruby" },
            -- Disable highlighting for large files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
        indent = { enable = true, disable = { "ruby" } },
        
        -- Incremental selection for better performance
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    },
}
