local core_utils = require("core.utils")
local fzf = require("fzf-lua")

fzf.setup({})

core_utils.map("<leader>ff", function()
  fzf.files()
end, "FZF Files")

core_utils.map("<leader>fg", function()
  fzf.live_grep()
end, "FZF Live Grep")

core_utils.map("<leader>fb", function()
  fzf.buffers()
end, "FZF Buffers")

core_utils.map("<leader>fh", function()
  fzf.help_tags()
end, "FZF Help Tags")

core_utils.map("<leader>fx", function()
  fzf.diagnostics_document()
end, "FZF Diagnostics Document")

core_utils.map("<leader>fX", function()
  fzf.diagnostics_workspace()
end, "FZF Diagnostics Workspace")
