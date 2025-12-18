local M = {}

function M.setup()
    local Terminal = require("toggleterm.terminal").Terminal

    -- Floating shell
    local float_term = Terminal:new({
        direction = "float",
        hidden = true,
        on_open = function(term)
            vim.cmd("startinsert!")
            M.set_terminal_keymaps(term.bufnr)
        end,
    })

    -- Floating LazyGit
    local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        on_open = function(term)
            vim.cmd("startinsert!")
            M.set_terminal_keymaps(term.bufnr)
        end,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>z", function()
        float_term:toggle()
    end, { desc = "Toggle floating terminal" })

    vim.keymap.set("n", "<leader>tg", function()
        lazygit:toggle()
    end, { desc = "Toggle LazyGit" })
end

function M.set_terminal_keymaps(bufnr)
    local opts = { buffer = bufnr, silent = true }

    -- Close terminal
    vim.keymap.set({ "n", "t" }, "q", "<cmd>close<cr>", opts)
    vim.keymap.set({ "n", "t" }, "<Esc>", "<cmd>close<cr>", opts)

    -- Better navigation
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

return M
