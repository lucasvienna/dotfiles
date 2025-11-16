-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local MAP = vim.keymap.set

MAP("n", "<leader>uW", ":set list!<CR>", { desc = "Toggle WhiteSpace" })

MAP("n", "<leader>bc", ":let @+ = expand('%:.')<CR>", { desc = "Copy Path" })

MAP("n", "<leader>L", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })

MAP("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
MAP("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
