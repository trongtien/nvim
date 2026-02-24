local M = {}

local copilot_ok, copilot = pcall(require, "copilot")
if copilot_ok then
  copilot.setup({
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        accept = "<CR>",
        next = "<C-j>",
        prev = "<C-k>",
        dismiss = "<C-e>",
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
        accept_word = false,
        accept_line = false,
        next = "<C-j>",
        prev = "<C-k>",
        dismiss = "<C-e>",
      },
    },
  })
end

return M
