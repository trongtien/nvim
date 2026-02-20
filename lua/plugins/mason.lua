return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { -- Add more languages as needed
                    "lua_ls",        -- Lua
                    "pyright",       -- Python
                    "rust_analyzer", -- Rust
                    "gopls",         -- Go
                    "bashls",        -- Bash
                    "jsonls",        -- JSON
                    "yamlls",        -- YAML
                    "ts_ls",         -- TypeScript/JavaScript (tsserver)
                    "eslint",        -- ESLint for JS/TS/React
                    "tailwindcss",   -- TailwindCSS (useful for React/Vue)
                    "html",          -- HTML
                    "cssls",         -- CSS
                    "svelte",        -- Svelte
                },
                automatic_installation = true,
            })
        end
    },
}
