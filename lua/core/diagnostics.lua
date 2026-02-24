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
    source = "always",
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

core_utils.map("<leader>dl", vim.diagnostic.open_float, "Show line diagnostics")


-- Open review error, dociment function, error ...
do
  local orig = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig(contents, syntax, opts, ...)
  end
end


return M
