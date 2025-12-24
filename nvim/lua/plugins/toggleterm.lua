-- ~/.config/nvim/lua/plugins/toggleterm.lua
-- LazyVim plugin specification for toggleterm with Monokai Pro theming

return {
    "akinsho/toggleterm.nvim",
    version = "*",

    keys = {
        {
            "<leader>z",
            desc = "󱅸 Toggle Terminal",
            noremap = true,
        },
        {
            "<leader>tg",
            desc = "󰊢 LazyGit Terminal",
            noremap = true,
        },
        {
            "<leader>tt",
            desc = "󰊢 Terminal (Vertical)",
            noremap = true,
        },
        {
            "<leader>tn",
            desc = "󰊢 New Terminal (Float)",
            noremap = true,
        },
    },

    opts = {
        direction = "float",
        float_opts = {
            border = "rounded",
            winblend = 10,
            zindex = 50,
            width = function()
                return math.floor(vim.o.columns * 0.85)
            end,
            height = function()
                return math.floor(vim.o.lines * 0.8)
            end,
        },
    },

    config = function(_, opts)
        require("toggleterm").setup(opts)

        -- ============================================
        -- Monokai Pro Theme Setup
        -- ============================================
        local monokai_pro = {
            bg = "#221f22",   -- Deep background
            border = "#A9DC76", -- Lime green for primary accent
            border_alt = "#FF6188", -- Hot pink for visual interest
            float_bg = "#2d2a2e", -- Slightly lighter background
        }

        -- Setup highlight groups for Monokai Pro theming
        vim.api.nvim_set_hl(0, "MonokaiProBorder", {
            fg = monokai_pro.border,
            bg = monokai_pro.float_bg,
            bold = true,
        })

        vim.api.nvim_set_hl(0, "MonokaiProFloat", {
            bg = monokai_pro.float_bg,
        })

        vim.api.nvim_set_hl(0, "MonokaiProBg", {
            bg = monokai_pro.bg,
        })

        vim.api.nvim_set_hl(0, "ToggleTermBorder", {
            fg = monokai_pro.border,
            bg = monokai_pro.float_bg,
            bold = true,
        })

        -- ============================================
        -- Terminal Instances & Custom Setup
        -- ============================================
        require("config.terminal").setup()

        local Terminal = require("toggleterm.terminal").Terminal

        -- Main floating terminal
        local main_terminal = Terminal:new({
            cmd = vim.o.shell,
            hidden = true,
            direction = "float",
            float_opts = opts.float_opts,
            on_open = function(term)
                vim.cmd("setlocal signcolumn=no")
                vim.cmd("setlocal foldcolumn=0")
                vim.wo.statusline = " %{b:term_title} "
            end,
        })

        -- LazyGit terminal
        local lazygit_terminal = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = opts.float_opts,
            on_open = function(term)
                vim.cmd("setlocal signcolumn=no")
            end,
        })

        -- Vertical split terminal
        local vertical_terminal = Terminal:new({
            cmd = vim.o.shell,
            hidden = true,
            direction = "vertical",
            size = function()
                return vim.o.columns * 0.4
            end,
        })

        -- ============================================
        -- Key Mappings
        -- ============================================

        -- Normal mode keymaps
        vim.keymap.set("n", "<leader>z", function()
            main_terminal:toggle()
        end, {
            noremap = true,
            silent = true,
            desc = "Toggle Floating Terminal",
        })

        vim.keymap.set("n", "<leader>tg", function()
            lazygit_terminal:toggle()
        end, {
            noremap = true,
            silent = true,
            desc = "Toggle LazyGit",
        })

        vim.keymap.set("n", "<leader>tt", function()
            vertical_terminal:toggle()
        end, {
            noremap = true,
            silent = true,
            desc = "Toggle Vertical Terminal",
        })

        -- Terminal mode keymaps for seamless navigation
        vim.keymap.set("t", "<leader>z", function()
            main_terminal:toggle()
        end, {
            noremap = true,
            silent = true,
            buffer = 0,
            desc = "Toggle Floating Terminal from Terminal",
        })

        vim.keymap.set("t", "<leader>tg", function()
            lazygit_terminal:toggle()
        end, {
            noremap = true,
            silent = true,
            buffer = 0,
            desc = "Toggle LazyGit from Terminal",
        })

        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
            noremap = true,
            desc = "Exit terminal mode",
        })

        -- Counter for new terminals
        local term_counter = 1

        -- Function to open a new floating terminal
        function _G.open_new_terminal()
            term_counter = term_counter + 1
            local new_term = Terminal:new({
                cmd = vim.o.shell,
                direction = "float",
                float_opts = opts.float_opts,
                on_open = function(term)
                    vim.cmd("setlocal signcolumn=no")
                    vim.cmd("setlocal foldcolumn=0")
                    vim.wo.statusline = " %{b:term_title} "
                end,
                -- Use count to create a new terminal each time
                count = term_counter
            })
            new_term:open()
        end

        -- Keymap for opening a new terminal
        vim.keymap.set("n", "<leader>tn", function()
            _G.open_new_terminal()
        end, {
            noremap = true,
            silent = true,
            desc = "New Floating Terminal",
        })
    end,
}
