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
  tailwindcss = {},

  emmet_ls = {
    filetypes = { "html", "css", "blade", "php" },
    init_options = {
      html = { options = { ["bem.enabled"] = true } },
    },
  },

  html = {
    file_types = {
      "html",
      "htmldjango",
      "blade",
      "django-html",
      "ejs",
      "erb",
      "handlebars",
      "hbs",
      "mustache",
      "razor",
    },
    init_options = {
      provideFormatter = true,
    },
    settings = {
      html = {
        validate = true,
      },
    },

  },

  intelephense = {
    environment = {
      includePaths = { "app", "routes", "resources/views" },
    },
    files = {
      maxSize = 5000000,
    },
    stubs = {
      "apache",
      "bcmath",
      "bz2",
      "calendar",
      "Core",
      "curl",
      "date",
      "dom",
      "fileinfo",
      "filter",
      "ftp",
      "hash",
      "iconv",
      "json",
      "libxml",
      "mbstring",
      "openssl",
      "pcre",
      "PDO",
      "pdo_mysql",
      "Phar",
      "readline",
      "Reflection",
      "session",
      "SimpleXML",
      "sockets",
      "sodium",
      "standard",
      "tokenizer",
      "xml",
      "xmlreader",
      "xmlwriter",
      "zip",
      "zlib",
      "laravel",
      "wordpress",
      "woocommerce",
    },
  },

  cssls = {
    settings = {
      css = {
        validate = true,
      },
      scss = {
        validate = true,
      },
      less = {
        validate = true,
      },
    },
  }
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

return M
