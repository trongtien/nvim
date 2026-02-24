local M          = {}

local luacheck   = require("efmls-configs.linters.luacheck")
local stylua     = require("efmls-configs.formatters.stylua")

local flake8     = require("efmls-configs.linters.flake8")
local black      = require("efmls-configs.formatters.black")

local prettier_d = require("efmls-configs.formatters.prettier_d")
local eslint_d   = require("efmls-configs.linters.eslint_d")

local fixjson    = require("efmls-configs.formatters.fixjson")

local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt      = require("efmls-configs.formatters.shfmt")

local cpplint    = require("efmls-configs.linters.cpplint")
local clangfmt   = require("efmls-configs.formatters.clang_format")

local go_revive  = require("efmls-configs.linters.go_revive")
local gofumpt    = require("efmls-configs.formatters.gofumpt")


local function load_tools()
  return {
    lua             = { luacheck, stylua },
    python          = { flake8, black },

    javascript      = { eslint_d, prettier_d },
    javascriptreact = { eslint_d, prettier_d },
    typescript      = { eslint_d, prettier_d },
    typescriptreact = { eslint_d, prettier_d },

    json            = { eslint_d, prettier_d },
    jsonc           = { eslint_d, fixjson },

    html            = { prettier_d },
    css             = { prettier_d },

    markdown        = { prettier_d },

    vue             = { eslint_d, prettier_d },
    svelte          = { eslint_d, prettier_d },

    sh              = { shellcheck, shfmt },

    go              = { go_revive, gofumpt },

    c               = { cpplint, clangfmt },
    cpp             = { cpplint, clangfmt },
  }
end

local languages = load_tools()

vim.lsp.config("efm", {
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true },
  settings = {
    languages = languages,
  },
})

vim.lsp.enable({ "efm" })

return M
