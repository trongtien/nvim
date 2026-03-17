return {
    "tpope/vim-fugitive",
    config = function()

        -- Floating notification top-right corner
        local function git_notify(msg, hl_group, timeout)
            local text = "  " .. msg .. "  "
            local width = #text
            local col = vim.o.columns - width - 2

            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

            local win = vim.api.nvim_open_win(buf, false, {
                relative = "editor",
                row = 1,
                col = col,
                width = width,
                height = 1,
                style = "minimal",
                border = "rounded",
                focusable = false,
                zindex = 200,
            })
            vim.wo[win].winhl = "Normal:" .. hl_group .. ",FloatBorder:" .. hl_group

            if timeout then
                vim.defer_fn(function()
                    pcall(vim.api.nvim_win_close, win, true)
                    pcall(vim.api.nvim_buf_delete, buf, { force = true })
                end, timeout)
            end

            return win, buf
        end

        -- Run git command async with loading → done/failed notification
        local function git_run(args, label)
            local win, buf = git_notify("⟳  " .. label .. "...", "DiagnosticInfo")

            vim.fn.jobstart(vim.list_extend({ "git" }, args), {
                on_exit = function(_, code)
                    vim.schedule(function()
                        pcall(vim.api.nvim_win_close, win, true)
                        pcall(vim.api.nvim_buf_delete, buf, { force = true })
                        if code == 0 then
                            git_notify("✓  " .. label .. " done", "DiagnosticOk", 3000)
                        else
                            git_notify("✗  " .. label .. " failed", "DiagnosticError", 5000)
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
                git_notify("✓  Committed", "DiagnosticOk", 3000)
            end,
        })

        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}
