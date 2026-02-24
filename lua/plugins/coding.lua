require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"lua_ls",
		"pyright",
		"bashls",
		"gopls",
		"clangd",
		"tailwindcss",
	},
	automatic_installation = true,
})

require("lsp.server")
require("lsp.efm")
