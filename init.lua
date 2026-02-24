package.path = vim.fn.stdpath("config") ..
"/lua/?.lua;" .. vim.fn.stdpath("config") .. "/lua/?/init.lua;" .. package.path

vim.pack.add({
  "https://www.github.com/ayu-theme/ayu-vim",
  "https://www.github.com/lewis6991/gitsigns.nvim",
  "https://www.github.com/echasnovski/mini.nvim",
  "https://www.github.com/ibhagwan/fzf-lua",
  "https://www.github.com/nvim-tree/nvim-tree.lua",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  -- Language Server Protocols
  "https://www.github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/creativenull/efmls-configs-nvim",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
  "https://github.com/L3MON4D3/LuaSnip",
})

local ui_color = require("uicolors")
ui_color.load_theme_current()
ui_color.set_transparent()

_G.file_type = ui_color.file_type
_G.file_size = ui_color.file_size
_G.mode_icon = ui_color.mode_icon
_G.git_branch = ui_color.git_branch

require("options")
require("keymaps")
require("autocmd")
require("plugins.status_line")
require("plugins.treesitter")
require("plugins.tree-folder")
require("plugins.float_term")
require("plugins.fzf_config")
require("plugins.mini_config")
require("plugins.git_config")
require("plugins.coding")
require("plugins.blink_cmp")
require("plugins.lazy_git")

