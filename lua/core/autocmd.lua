local M = {}
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

M.auto_cmd = function(event, opts)
  opts.group = augroup
  vim.api.nvim_create_autocmd(event, opts)
end


M.auto_cmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- return to last cursor position
M.auto_cmd("BufReadPost", {
  group = augroup,
  desc = "Restore last cursor position",
  callback = function()
    if vim.o.diff then -- except in diff mode
      return
    end

    local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
    local last_line = vim.api.nvim_buf_line_count(0)

    local row = last_pos[1]
    if row < 1 or row > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})

M.auto_cmd("FileType", {
  group = augroup,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

M.auto_cmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

M.auto_cmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

if vim.fn.has("wsl") == 1 then
    M.auto_cmd("TextYankPost", {
        callback = function()
            vim.fn.system("clip.exe", vim.fn.getreg('"'))
        end,
    })
    vim.opt.clipboard = "unnamedplus"
end

return M
