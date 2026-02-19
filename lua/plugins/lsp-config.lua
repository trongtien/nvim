return {
    "neovim/nvim-lspconfig",
     event = "VeryLazy",
    config = function()
      require("nvchad.configs.lspconfig").defaults()

      local nvChad_config = require("nvchad.configs.lspconfig")
      local on_attach = nvChad_config.on_attach
      local on_init = nvChad_config.on_init
      local capabilities = nvChad_config.capabilities

      local servers = {
        "lua_ls",
        "html",
        "jsonls",
        "yamlls",
        "cssls",
        "eslint",       -- ESLint
        "tailwindcss",  -- TailwindCSS
      }

      -- Setup standard servers using new vim.lsp.config API
      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
        })
        vim.lsp.enable(lsp)
      end

      -- Python setup with Pyright
      vim.lsp.config('pyright', {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",  -- "off", "basic", or "strict"
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              autoImportCompletions = true,
            }
          }
        }
      })
      vim.lsp.enable('pyright')

      -- Python Ruff LSP for fast linting and formatting
      vim.lsp.config('ruff', {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        init_options = {
          settings = {
            args = {}
          }
        }
      })
      vim.lsp.enable('ruff')

      -- Go setup with gopls
      vim.lsp.config('gopls', {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          }
        }
      })
      vim.lsp.enable('gopls')

      -- Rust setup with rust-analyzer
      vim.lsp.config('rust_analyzer', {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",  -- Use clippy for more thorough checks
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
            inlayHints = {
              lifetimeElisionHints = {
                enable = "always",
              },
            },
          }
        }
      })
      vim.lsp.enable('rust_analyzer')

      -- Vue setup with Volar (Vue 3)
      vim.lsp.config('volar', {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        filetypes = { "vue", "typescript", "javascript" },
        init_options = {
          typescript = {
            tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib"
          }
        }
      })
      vim.lsp.enable('volar')

      -- TypeScript/JavaScript specific configuration for React and NestJS
      vim.lsp.config('ts_ls', {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })
      vim.lsp.enable('ts_ls')
    end
}

