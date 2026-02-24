local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

local format_patterns = {
  "*.lua", "*.py", "*.go",
  "*.js", "*.jsx", "*.ts", "*.tsx",
  "*.json", "*.css", "*.scss", "*.html",
  "*.sh", "*.bash", "*.zsh",
  "*.c", "*.cpp", "*.h", "*.hpp",
}

local function has_efm(bufnr)
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if c.name == "efm" then
      return true
    end
  end
  return false
end

local function format_on_save(args)
  local bufnr = args.buf
  local bo = vim.bo[bufnr]

  if bo.buftype ~= "" or not bo.modifiable then
    return
  end

  if vim.api.nvim_buf_get_name(bufnr) == "" then
    return
  end

  if not has_efm(bufnr) then
    return
  end

  pcall(vim.lsp.buf.format, {
    bufnr = bufnr,
    timeout_ms = 2000,
    filter = function(c)
      return c.name == "efm"
    end,
  })
end


vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = format_patterns,
  callback = format_on_save,
})

return M
