local M = {}

local capabilities = require("lsp.capabilities")

-- Global lsp default config
vim.lsp.config["*"] = {
  capabilities = capabilities
}

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        telemetry = { enable = false },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },

  pyright = {},
  bashls = {},
  ts_ls = {},
  gopls = {},
  clangd = {},
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

return M
