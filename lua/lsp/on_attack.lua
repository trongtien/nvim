local M = {}

local augroup = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then return end

  local bufnr = ev.buf
  local opts = { buffer = bufnr, silent = true }
  local utils = require("core.utils")
  local fzf_ok, fzf = pcall(require, "fzf_lua")
  if not fzf_ok then fzf = nil end

  -- Basic LSP
  utils.map("K", vim.lsp.buf.hover, "Hover", opts)
  utils.map("<leader>rn", vim.lsp.buf.rename, "Rename", opts)
  utils.map("<leader>ca", vim.lsp.buf.code_action, "Code Action", opts)
  utils.map("<leader>gf", vim.lsp.buf.format, "Format", opts)

  -- Diagnostics
  utils.map("<leader>d", function()
    vim.diagnostic.open_float({ scope = "cursor" })
  end, "Cursor Diagnostic", opts)

  utils.map("<leader>D", function()
    vim.diagnostic.open_float({ scope = "line" })
  end, "Line Diagnostic", opts)

  utils.map("<leader>nd", function()
    vim.diagnostic.jump({ count = 1 })
  end, "Next Diagnostic", opts)

  utils.map("<leader>pd", function()
    vim.diagnostic.jump({ count = -1 })
  end, "Prev Diagnostic", opts)

  -- FZF navigation
  if fzf then
    utils.map("<leader>gd", function()
      fzf.lsp_definitions({ jump_to_single_result = true })
    end, "Definitions", opts)

    utils.map("<leader>fr", fzf.lsp_references, "References", opts)
    utils.map("<leader>fi", fzf.lsp_implementations, "Implementations", opts)
    utils.map("<leader>ft", fzf.lsp_typedefs, "Type Definitions", opts)
    utils.map("<leader>fs", fzf.lsp_document_symbols, "Document Symbols", opts)
    utils.map("<leader>fw", fzf.lsp_workspace_symbols, "Workspace Symbols", opts)
  end

  -- Organize imports
  if client:supports_method("textDocument/codeAction", bufnr) then
    utils.map("<leader>oi", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })

      vim.defer_fn(function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, 50)
    end, "Organize Imports", opts)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = lsp_on_attach,
})

return M
