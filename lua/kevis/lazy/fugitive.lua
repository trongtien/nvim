return {
    "tpope/vim-fugitive",
    config = function()
        -- Run git command async with loading → done/failed notification
        local function git_run(args, label)
            vim.notify("⟳  " .. label .. "...", vim.log.levels.INFO)

            vim.fn.jobstart(vim.list_extend({ "git" }, args), {
                on_exit = function(_, code)
                    vim.schedule(function()
                        if code == 0 then
                            vim.notify("✓  " .. label .. " done", vim.log.levels.INFO)
                        else
                            vim.notify("✗  " .. label .. " failed", vim.log.levels.ERROR)
                        end
                    end)
                end,
            })
        end

        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd

        autocmd("BufWinEnter", {
            group = ThePrimeagen_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
                vim.keymap.set("n", "<leader>p", function()
                    git_run({ "push" }, "Push")
                end, opts)

                -- rebase always
                vim.keymap.set("n", "<leader>P", function()
                    git_run({ "pull", "--rebase" }, "Pull")
                end, opts)

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
            end,
        })

        -- Notify when commit message is saved (committed)
        autocmd("BufWritePost", {
            group = ThePrimeagen_Fugitive,
            pattern = "COMMIT_EDITMSG",
            callback = function()
                vim.notify("✓  Committed", vim.log.levels.INFO)
            end,
        })

        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}
