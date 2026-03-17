return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "▎" },
		},
		numhl = true,
		linehl = false,
		word_diff = false,
		watch_gitdir = { interval = 1000, follow_files = true },
		attach_to_untracked = true,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 500,
		},
		current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> · <summary>",
	},
	config = function(_, opts)
		require("gitsigns").setup(opts)
	end,
}
