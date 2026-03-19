return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        local function get_prettier()
            local local_prettier = vim.fn.getcwd() .. "/node_modules/.bin/prettier"
            if vim.fn.executable(local_prettier) == 1 then
                return { local_prettier }
            end
            return { "prettier" }
        end

        require("conform").setup({
            format_on_save = {
                timeout_ms = 5000,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                lua = { "stylua" },
                go = { "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                elixir = { "mix" },
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = { "-style=file", "-fallback-style=LLVM" },
                },
                ["prettier"] = {
                    command = function()
                        return get_prettier()[1]
                    end,
                },
            },
        })

        vim.keymap.set("n", "<leader>gf", function()
            require("conform").format({ bufnr = 0 })
        end)
    end,
}
