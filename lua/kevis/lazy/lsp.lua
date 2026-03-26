return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "zls" },
                { name = "buffer" },
                { name = "path" },
                { name = "pylsp" },
                { name = "gci" },
                { name = "ts_ls" },
                { name = "gopls" },
                { name = "nix" },
                { name = "buf_ls" },
                { name = "render-markdown" },
                { name = "cobol_ls" },
            }),
            sorting = {
                priority_weight = 2,
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })


        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        -- lua
        vim.lsp.config["lua_ls"] = {
            cmd = { "lua-language-server" },
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        }
        vim.lsp.enable("lua_ls")

        vim.lsp.config["ts_ls"] = {
            capabilities = capabilities,
        }

        vim.lsp.config["eslint"] = {
            capabilities = capabilities,
        }

        vim.lsp.config["zls"] = {
            capabilities = capabilities,
        }

        vim.lsp.config["yamlls"] = {
            capabilities = capabilities,
        }

        vim.lsp.config["tailwindcss"] = {
            capabilities = capabilities,
        }

        vim.lsp.config["gopls"] = {
            capabilities = capabilities,
        }

        -- nix
        vim.lsp.config["nil_ls"] = {
            capabilities = capabilities,
        }

        -- protocol buffer
        vim.lsp.config["buf_ls"] = {
            capabilities = capabilities,
        }

        -- docker compose
        vim.lsp.config["docker_compose_language_service"] = {
            capabilities = capabilities,
        }

        -- cobol
        vim.lsp.config["cobol_ls"] = {
            capabilities = capabilities,
        }

        -- svelte
        vim.lsp.config["svelte"] = {
            capabilities = capabilities,
        }
        -- python
        vim.lsp.config["pyright"] = {
            capabilities = capabilities,
        }

        -- bash
        vim.lsp.config["bashls"] = {
            capabilities = capabilities,
        }

        -- protocol buffer
        vim.lsp.config["buf_language_server"] = {
            capabilities = capabilities,
        }

        vim.lsp.config["asm_lsp"] = {
            capabilities = capabilities,
        }

        vim.lsp.config["rust_analyzer"] = {
            capabilities = capabilities,
        }

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "proto",
            callback = function()
                vim.lsp.enable("buf_language_server")
            end,
        })

        vim.lsp.enable({
            "ts_ls",
            "eslint",
            "yamlls",
            "tailwindcss",
            "gopls",
            "nil_ls",
            "buf_ls",
            "docker_compose_language_service",
            "svelte",
            "pyright",
            "bashls",
            "asm_lsp",
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
