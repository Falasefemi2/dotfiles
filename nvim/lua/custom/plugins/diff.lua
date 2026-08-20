-- diffview.nvim configuration (package is added in main config)
pcall(function()
  require('diffview').setup {
    enhanced_diff_hl = true,
    use_icons = vim.g.have_nerd_font,
  }
end)
