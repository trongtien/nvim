return {
    {
        "stevearc/conform.nvim",
        config = function()
            local options = {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black" },
                    css = { "prettier" },
                    html = { "prettier" },
                },

                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            }

            require("conform").setup(options)
        end
    }
}
