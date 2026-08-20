vim.pack.add { 'https://github.com/nvim-zh/colorful-winsep.nvim' }
require('colorful-winsep').setup {
  border = "bold",
  excluded_ft = { "packer", "TelescopePrompt", "mason" },
  animate = {
    enabled = "shift",
    shift = {
      delay = 16,
      frames = 15,
      easing = "ease_out_cubic",
    },
  },
}
