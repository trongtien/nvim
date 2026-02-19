return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      -- Add or override the filesystem_watchers config
      opts.filesystem_watchers = opts.filesystem_watchers or {}
      opts.filesystem_watchers.enable = true
      opts.filesystem_watchers.debounce_delay = 50
      opts.filesystem_watchers.ignore_dirs = {
        "node_modules",
        ".git",
        "target",
        "build",
        "dist",
        ".cache",
        ".vscode",
        ".idea",
      }
      
      return opts
    end,
  },
}
