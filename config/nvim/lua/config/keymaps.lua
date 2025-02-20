-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "ask" })
vim.keymap.set({ "n", "v" }, "<leader>ar", "<cmd>AvanteAsk<cr>", { desc = "refresh" })
