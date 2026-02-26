local utils = require("core.utils")
local nvim_tree = require("nvim-tree")
nvim_tree.setup({
	view = {
		width = 35,
	},
	filters = {
		dotfiles = false,
		git_ignored = false,  -- Show gitignored files
		custom = {},          -- No custom filters
	},
	renderer = {
		group_empty = true,
	},
})


utils.map("<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, "Toggle NvimTree")

utils.map("<leader>fe", function()
	require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, "Focus current file in NvimTree")

vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
