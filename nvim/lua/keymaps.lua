-- Global LSP diagnostic keybindings
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })

-- Oil keybindings
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", "<CMD>Oil .<CR>", { desc = "Open current directory" })

-- Theme keybindings
vim.keymap.set("n", "<leader>th", ":Themery<CR>", { desc = "Open theme picker" })