vim.g.mapleader = " "

vim.opt.timeout = false
vim.opt.ttimeoutlen = -1
vim.opt.guicursor = "n-v-c:block-blinkon1-CursorInsert,i:block-CursorInsert"

vim.diagnostic.config({
    virtual_text = true,
})

vim.keymap.set("n", "<leader><leader>", "<cmd>:w<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>:q<cr>")

vim.keymap.set("n", "sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "sh", ":split<CR>", { desc = "Split window horizontally" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<C-K>", ":resize +6<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-J>", ":resize -6<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-L>", ":vertical resize -6<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-H>", ":vertical resize +6<CR>", { desc = "Increase window width" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>lt", function()
    vim.cmd [[ PlenaryBustedFile % ]]
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics error" })
vim.keymap.set("n", "<leader>re", vim.diagnostic.open_float, { desc = "Show diagnostics error" })

vim.keymap.set("n", "<leader>pv", function() vim.cmd("Explore") end)
