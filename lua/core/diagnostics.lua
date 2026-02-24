local M = {}
local core_utils = require("core.utils")

local icons = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = "",
}


vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.INFO] = icons.Info,
      [vim.diagnostic.severity.HINT] = icons.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

-- Global keymap
core_utils.map("<leader>q", function()
  vim.diagnostic.setloclist({ open = true })
end, "Open diagnostic list")

core_utils.map("<leader>re", vim.diagnostic.open_float, "Show line diagnostics")

core_utils.map("<leader>rf", function()
  vim.diagnostic.open_float()
end, "Focus diagnostic float")

core_utils.map("<leader>ne", function()
  vim.diagnostic.goto_next({ wrap = true })
end, "Next diagnostic")

core_utils.map("<leader>pe", function()
  vim.diagnostic.goto_prev({ wrap = true })
end, "Previous diagnostic")

return M
