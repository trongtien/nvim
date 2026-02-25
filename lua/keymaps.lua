local utils = require("core.utils")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

utils.map_expr("j", function()
	return vim.v.count == 0 and "gj" or "j"
end, "Down (wrap-aware)")

utils.map_expr("k", function()
	return vim.v.count == 0 and "gk" or "k"
end, "Up (wrap-aware)")

utils.map("<leader>c", ":nohlsearch<CR>", "Clear search highlights")
utils.map("i", "jj", "<Esc>", "Exit insert mode")

utils.map("n", "nzzzv", "Next search result (centered)")
utils.map("N", "Nzzzv", "Previous search result (centered)")
utils.map("<C-d>", "<C-d>zz", "Half page down (centered)")
utils.map("<C-u>", "<C-u>zz", "Half page up (centered)")

utils.map_mode("x", "<leader>p", '"_dP', "Paste without yanking")
utils.map_mode({ "n", "v" }, "<leader>x", '"_d', "Delete without yanking")

utils.map("<leader>bn", ":bnext<CR>", "Next buffer")
utils.map("<leader>bp", ":bprevious<CR>", "Previous buffer")

utils.map("<C-h>", "<C-w>h", "Move to left window")
utils.map("<C-j>", "<C-w>j", "Move to bottom window")
utils.map("<C-k>", "<C-w>k", "Move to top window")
utils.map("<C-l>", "<C-w>l", "Move to right window")

utils.map("sv", ":vsplit<CR>", "Split window vertically")
utils.map("sh", ":split<CR>", "Split window horizontally")

utils.map("<C-Up>", ":resize +2<CR>", "Increase window height")
utils.map("<C-Down>", ":resize -2<CR>", "Decrease window height")
utils.map("<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
utils.map("<C-Right>", ":vertical resize +2<CR>", "Increase window width")

utils.map("<A-j>", ":m .+1<CR>==", "Move line down")
utils.map("<A-k>", ":m .-2<CR>==", "Move line up")
utils.map_mode("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
utils.map_mode("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

utils.map_mode("v", "<", "<gv", "Indent left and reselect")
utils.map_mode("v", ">", ">gv", "Indent right and reselect")

utils.map("J", "mzJ`z", "Join lines and keep cursor position")

utils.map("<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, "Copy full file path")

utils.map("<C-s>", ":w<CR>", "Save buffer")
utils.map_mode("i", "<C-s>", "<Esc>:w<CR>", "Save buffer")

utils.map("<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, "Toggle diagnostics")

utils.map("<leader>ne", function()
	vim.diagnostic.goto_next({ buffer = 0 })
end, "Next error buffer")

utils.map("<leader>pe", function()
	vim.diagnostic.goto_prev({ buffer = 0 })
end, "Prev error buffer")

utils.map("<leader>re", function()
	vim.diagnostic.open_float({ scope = "line" })
end, "Show error line")
