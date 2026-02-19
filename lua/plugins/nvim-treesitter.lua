return {
  	"nvim-treesitter/nvim-treesitter",
     event = "VeryLazy",
    build = ":TSUpdate",
  	opts = {
  		ensure_installed = {
        "vim",
        "lua",
        "rust",
        "markdown",
        "vimdoc",
        "markdown_inline",
        "python",
        "cpp",
        "make",
        "dockerfile",
        "html",
        "css",
        "go",
        "javascript",
        "typescript",
        "tsx",
        "jsx",
        "vue",
        "json",
        "yaml"
      },
        auto_install = true,

 highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
  	},
}
