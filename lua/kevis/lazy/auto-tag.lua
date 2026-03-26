return {
    "windwp/nvim-ts-autotag",
    opts = {
        enable_close = true,           -- Auto close tags
        enable_rename = true,          -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
    config = function()
        require("nvim-ts-autotag").setup()
        per_filetype = {
            ["html"] = {
                enable_close = false,
            },
        }
    end,
}
