-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set
local k = vim.keycode
local f = require("custom.f")
local fn = f.fn

-- ============================================================================
-- SPLIT NAVIGATION - Move between splits with Ctrl + hjkl
-- ============================================================================
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

-- ============================================================================
-- FILE OPERATIONS - Save and execute
-- ============================================================================
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- SAVE FILE - Ctrl+S to save (works in normal and insert mode)
set("n", "<c-s>", "<cmd>w<CR>", { desc = "Save current file" })
set("i", "<c-s>", "<Esc><cmd>w<CR>", { desc = "Save current file" })

-- ============================================================================
-- SEARCH - Smart Enter key behavior
-- ============================================================================
-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.v.hlsearch == 1 then
    vim.cmd.nohl()
    return ""
  else
    return k("<CR>")
  end
end, { expr = true })

-- ============================================================================
-- TAB NAVIGATION - Left/Right arrows to switch tabs
-- ============================================================================
-- Normally these are not good mappings, but I have left/right on my thumb
-- cluster, so navigating tabs is quite easy this way.
set("n", "<left>", "gT")
set("n", "<right>", "gt")

-- ============================================================================
-- DIAGNOSTICS - Jump between errors with visual feedback
-- ============================================================================
-- There are builtin keymaps for this now, but I like that it shows
-- the float when I navigate to the error - so I override them.
set("n", "]d", fn(vim.diagnostic.jump, { count = 1, float = true }))
set("n", "[d", fn(vim.diagnostic.jump, { count = -1, float = true }))

-- ============================================================================
-- SPLIT RESIZING - Control split dimensions with Alt + keys
-- ============================================================================
-- Decrease split width (make narrower)
set("n", "<M-,>", "<c-w>5<", { desc = "Decrease split width" })
-- Increase split width (make wider)
set("n", "<M-.>", "<c-w>5>", { desc = "Increase split width" })
-- Increase split height
set("n", "<M-t>", "<C-W>+", { desc = "Increase split height" })
-- Decrease split height
set("n", "<M-s>", "<C-W>-", { desc = "Decrease split height" })

-- ============================================================================
-- LINE MOVEMENT - Move lines up/down with Alt+J/K
-- ============================================================================
set("n", "<M-j>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! ]c]])
  else
    vim.cmd([[m .+1<CR>==]])
  end
end, { desc = "Move line down" })

set("n", "<M-k>", function()
  if vim.opt.diff:get() then
    vim.cmd([[normal! [c]])
  else
    vim.cmd([[m .-2<CR>==]])
  end
end, { desc = "Move line up" })

-- ============================================================================
-- INLAY HINTS - Toggle type hints display
-- ============================================================================
set("n", "<space>tt", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

-- ============================================================================
-- TESTING - Run tests on current file
-- ============================================================================
vim.api.nvim_set_keymap("n", "<leader>t", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

-- ============================================================================
-- SMART LINE NAVIGATION - j/k respect line wrapping
-- ============================================================================
-- When count is 0 (no prefix), use gj (visual movement)
-- When count is given, use j (literal line movement)
set("n", "j", function(...)
  local count = vim.v.count
  if count == 0 then
    return "gj"
  else
    return "j"
  end
end, { expr = true, desc = "Smart down movement" })

set("n", "k", function(...)
  local count = vim.v.count
  if count == 0 then
    return "gk"
  else
    return "k"
  end
end, { expr = true, desc = "Smart up movement" })

-- ============================================================================
-- QUICKFIX NAVIGATION - Jump through search/grep results
-- ============================================================================
vim.keymap.set("n", "]]", "<cmd>cnext<CR>", { silent = true, desc = "Next quickfix item" })
vim.keymap.set("n", "[[", "<cmd>cprev<CR>", { silent = true, desc = "Previous quickfix item" })

-- ============================================================================
-- SPLIT CREATION AND MANAGEMENT - NEW KEYMAPS
-- ============================================================================
-- Split window vertically (creates side-by-side windows)
set("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Vertical split (side-by-side)" })
-- Split window horizontally (creates top-bottom windows)
set("n", "<leader>s", "<cmd>split<CR>", { desc = "Horizontal split (top-bottom)" })
-- Close current split/window
set("n", "<leader>q", "<cmd>q<CR>", { desc = "Close current split" })

-- ============================================================================
-- BONUS: WINDOW EQUALIZATION - Make all splits equal size
-- ============================================================================
-- Press <leader>= to make all splits equal height and width
set("n", "<leader>=", "<cmd>wincmd =<CR>", { desc = "Make all splits equal size" })

-- BONUS: MAXIMIZE CURRENT SPLIT
-- Press <leader>o to maximize current split (like tmux zoom)
set("n", "<leader>o", "<cmd>wincmd _<bar>wincmd |<CR>", { desc = "Maximize current split" })
