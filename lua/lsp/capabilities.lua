local M = {}

local blink_ok, blink = pcall(require, "blink.cmp")
if blink_ok then
  M.capabilities = blink.get_lsp_capabilities()
else
  M.capabilities = vim.lsp.protocol.make_client_capabilities()
end

return M
