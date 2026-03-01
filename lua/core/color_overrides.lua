local M = {}

function M.custom_theme_overrides()
  local hl = vim.api.nvim_set_hl

  hl(0, "Normal", { fg = "#FEFEFE", bg = "#202020" })
  hl(0, "NormalFloat", { fg = "#FEFEFE", bg = "#202020" })
  hl(0, "Comment", { fg = "#6f7b68" })
  hl(0, "TSComment", { fg = "#6f7b68" })
  hl(0, "Conceal", { bg = "#262626" })
  hl(0, "Constant", { fg = "#cccccc" })
  hl(0, "DiffAdd", { fg = "#FFFEDB", bg = "#2B3328" })
  hl(0, "DiffChange", { fg = "#FFFEDB", bg = "#262636" })
  hl(0, "DiffDelete", { fg = "#C34143", bg = "#42242B" })
  hl(0, "DiffText", { fg = "#FFFEDB", bg = "#49443C" })
  hl(0, "Directory", { fg = "#C1C88D" })
  hl(0, "Error", { fg = "#C34143", undercurl = true })
  hl(0, "ErrorMsg", { fg = "#FFFEDB" })
  hl(0, "Function", { fg = "#AA9AAC" })
  hl(0, "Identifier", { fg = "#8B9698" })
  hl(0, "LineNrAbove", { fg = "#888888", bg = "#222222" })
  hl(0, "LineNrBelow", { fg = "#888888", bg = "#222222" })
  hl(0, "LineNr", { fg = "#d6d2c8" })
  hl(0, "MatchParen", { fg = "#FFFEDB" })
  hl(0, "NonText", { fg = "#303030" })
  hl(0, "Operator", { fg = "#DEBF7C" })
  hl(0, "Pmenu", { fg = "#918988", bg = "#303030" })
  hl(0, "PmenuSbar", { fg = "#918988", bg = "#262626" })
  hl(0, "PmenuSel", { fg = "#BFBBBA", bg = "#303030" })
  hl(0, "PmenuThumb", { fg = "#918988", bg = "#262626", reverse = true })
  hl(0, "PreProc", { fg = "#8B9698" })
  hl(0, "Question", { fg = "#9b8d7f" })
  hl(0, "QuickFixLine", { bg = "#303030" })
  hl(0, "Search", { bg = "#5F5958" })
  hl(0, "Special", { fg = "#cccccc" })
  hl(0, "SpecialChar", { fg = "#C1C88D" })
  hl(0, "SpecialKey", { fg = "#676767" })
  hl(0, "Statement", { fg = "#cccccc" })
  hl(0, "StatusLine", { fg = "#FFFEDB", bg = "#34383C" })
  hl(0, "String", { fg = "#A2A970" })
  hl(0, "Structure", { fg = "#AA9AAC" })
  hl(0, "Substitute", { fg = "#1A1A1A", bg = "#C1C88D" })
  hl(0, "TabLine", { fg = "#A09998", bg = "#212121" })
  hl(0, "TabLineFill", { fg = "#A09998", bg = "#212121" })
  hl(0, "TabLineSel", { fg = "#A09998", bg = "#40474F" })
  hl(0, "Title", { fg = "#FFFEDB" })
  hl(0, "Todo", { fg = "#8B9698" })
  hl(0, "Type", { fg = "#E3D896" })
  hl(0, "Underlined", { undercurl = true })
  hl(0, "VertSplit", { fg = "#303030" })
  hl(0, "Visual", { bg = "#454545" })
  hl(0, "WarningMsg", { fg = "#FFFEDB" })
  hl(0, "Float", { fg = "#6f7b68" })
  hl(0, "Number", { fg = "#6f7b68" })
  hl(0, "Boolean", { fg = "#6f7b68" })
  hl(0, "WinSeparator", { bg = "#111111", fg = "#888888" })
end

function M.setup_colorscheme_overrides()
  vim.api.nvim_create_autocmd("ColorScheme", {
    nested = true,
    pattern = "*",
    callback = function()
      M.custom_theme_overrides()
    end,
  })

  local grpid = vim.api.nvim_create_augroup('custom_highlights', {})
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = grpid,
    pattern = '*',
    command = 'hi Comment gui=NONE'
  })
end

vim.api.nvim_create_user_command("MyLine", function()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888", bg = "#222222" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888", bg = "#222222" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#d6d2c8" })
end, {})

return M
