local utils = require("core.utils")

local lazygit_state = { buf = nil, win = nil, is_open = false }

local function LazyGit()
	if lazygit_state.is_open and lazygit_state.win and vim.api.nvim_win_is_valid(lazygit_state.win) then
		vim.api.nvim_win_close(lazygit_state.win, false)
		lazygit_state.is_open = false
		return
	end

	if not lazygit_state.buf or not vim.api.nvim_buf_is_valid(lazygit_state.buf) then
		lazygit_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[lazygit_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	lazygit_state.win = vim.api.nvim_open_win(lazygit_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[lazygit_state.win].winblend = 0
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

	vim.fn.termopen("lazygit", {
		on_exit = function()
			if lazygit_state.is_open and lazygit_state.win and vim.api.nvim_win_is_valid(lazygit_state.win) then
				vim.api.nvim_win_close(lazygit_state.win, false)
				lazygit_state.is_open = false
			end
		end,
	})

	lazygit_state.is_open = true
	vim.cmd("startinsert")

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = lazygit_state.buf,
		callback = function()
			if lazygit_state.is_open and lazygit_state.win and vim.api.nvim_win_is_valid(lazygit_state.win) then
				vim.api.nvim_win_close(lazygit_state.win, false)
				lazygit_state.is_open = false
			end
		end,
		once = true,
	})
end

utils.map("<leader>gg", LazyGit, "Toggle LazyGit")
