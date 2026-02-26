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

M.auto_cmd("BufWinEnter", {
  group = augroup,
  callback = function()
    vim.opt_local.modifiable = true
  end,
})

M.auto_cmd("LspAttach", {
  group = augroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>gf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>sw", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>sd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>sr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  end,
})

return M
