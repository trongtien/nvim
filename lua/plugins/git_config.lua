local utils = require("core.utils")

require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" }, -- ▏
		change = { text = "\u{2590}" }, -- ▐
		delete = { text = "\u{2590}" }, -- ◦
		topdelete = { text = "\u{25e6}" }, -- ◦
		changedelete = { text = "\u{25cf}" }, -- ●
		untracked = { text = "\u{25cb}" }, -- ○
	},
	signcolumn = true,
	current_line_blame = false,
})

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local FugitiveGroup = vim.api.nvim_create_augroup("Fugitive", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = FugitiveGroup,
	pattern = "*",
	callback = function()
		if vim.bo.ft ~= "fugitive" then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "<leader>p", function()
			vim.cmd.Git("push")
		end, opts)

		vim.keymap.set("n", "<leader>P", function()
			vim.cmd.Git({ "pull", "--rebase" })
		end, opts)

		vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
	end,
})

vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")

utils.map("]h", function()
	require("gitsigns").next_hunk()
end, "Next git hunk")

utils.map("[h", function()
	require("gitsigns").prev_hunk()
end, "Previous git hunk")

utils.map("<leader>hs", function()
	require("gitsigns").stage_hunk()
end, "Stage hunk")

utils.map("<leader>hr", function()
	require("gitsigns").reset_hunk()
end, "Reset hunk")

utils.map("<leader>hp", function()
	require("gitsigns").preview_hunk()
end, "Preview hunk")

utils.map("<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, "Blame line")

utils.map("<leader>hB", function()
	require("gitsigns").toggle_current_line_blame()
end, "Toggle inline blame")

utils.map("<leader>hd", function()
	require("gitsigns").diffthis()
end, "Diff this")
