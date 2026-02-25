local core_utils = require("core.utils")
local fzf = require("fzf-lua")

fzf.setup({
  winopts = {
    width = 1,
    height = 0.9,
    row = 0.8,
    col = 0,
    border = "rounded",
    relative = "editor",
  },
})

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

core_utils.map("<C-q>", function()
  fzf.diagnostics()
end, "FZF Diagnostics")

core_utils.map("<leader>gb", function()
  fzf.git_branches()
end, "FZF Git Branches")

core_utils.map("<leader>gc", function()
  fzf.git_commits()
end, "FZF Git Commits")

core_utils.map("<leader>gs", function()
  fzf.git_status()
end, "FZF Git Status")


