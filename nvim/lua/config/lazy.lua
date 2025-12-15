local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim",                                import = "lazyvim.plugins" },

        -- web devicons
        {
            "nvim-tree/nvim-web-devicons",
            lazy = true,
        },

        -- material icons
        {
            "DaikyXendo/nvim-material-icon",
        },

        -- import any extras modules here
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.ui.mini-animate" },
        { import = "lazyvim.plugins.extras.lang.go" },
        { import = "lazyvim.plugins.extras.lang.tailwind" },
        { import = "lazyvim.plugins.extras.test.core" },
        { import = "lazyvim.plugins.extras.lsp.none-ls" },
        { import = "lazyvim.plugins.extras.dap.core" },

        -- import/override with your plugins
        { import = "plugins" },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
