return {
	"github/copilot.vim",
	build = ":Copilot setup",
	cmd = { "Copilot" },
	init = function()
		vim.g.copilot_tab_fallback = ""
		vim.keymap.set("i", "<tab>", function()
			return vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)) or ""
		end, { expr = true, buffer = true })
	end,
}
