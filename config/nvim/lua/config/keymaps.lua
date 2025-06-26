-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "ask" })
vim.keymap.set({ "n", "v" }, "<leader>ar", "<cmd>AvanteAsk<cr>", { desc = "refresh" })

-- to disable the nasty <esc> + jk dragging lines issue
vim.api.nvim_del_keymap("n", "<M-k>")
vim.api.nvim_del_keymap("n", "<M-j>")
vim.api.nvim_del_keymap("v", "<M-k>")
vim.api.nvim_del_keymap("v", "<M-j>")
vim.api.nvim_del_keymap("i", "<M-k>")
vim.api.nvim_del_keymap("i", "<M-j>")
