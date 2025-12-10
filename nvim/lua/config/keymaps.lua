-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/config/keymaps.lua
local map = vim.keymap.set

-- Save with Ctrl+S from insert mode (and stay in insert mode)
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file and stay in insert mode" })

-- Bonus: also make Ctrl+S work in normal mode (optional but nice)
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Bonus 2: many people also add it in visual/select mode
map("v", "<C-s>", "<Esc>:w<CR>gv", { desc = "Save and reselect" })
