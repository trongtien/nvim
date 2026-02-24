require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "hide" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = { menu = { auto_show = true } },
  sources = { default = { "lsp", "path", "buffer", "snippets" } },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
  },

  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { download = true },
  },
})

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if require("blink.cmp").is_visible() then
    return require("blink.cmp").select_next()
  end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if require("blink.cmp").is_visible() then
    return require("blink.cmp").select_prev()
  end
end, { expr = true })

