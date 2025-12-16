-- Autotag configuration for nvim-ts-autotag
-- This file is created to explicitly include the plugin configuration,
-- even though `config = true` in lazy.lua would call setup automatically.
-- Custom options can be added here if needed.

return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "javascriptreact", "typescriptreact", "vue" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}