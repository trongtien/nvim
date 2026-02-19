return {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
        local null_ls = require "null-ls"
        local opts = {
            sources = {
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.clang_format, -- c++ formatting tool
                null_ls.builtins.formatting.black,    -- python formatting tool
                null_ls.builtins.diagnostics.mypy,    -- load null-ls' diagnostics tools
                null_ls.builtins.diagnostics.ruff,    -- 'mypy' and 'ruff' for static type
                null_ls.builtins.formatting.stylua,   -- Lua
                null_ls.builtins.formatting.shfmt,    -- Bash
            },
        }

        null_ls.setup(opts)
    end,
}
