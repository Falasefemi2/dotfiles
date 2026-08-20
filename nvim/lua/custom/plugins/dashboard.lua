vim.pack.add { 'https://github.com/nvimdev/dashboard-nvim' }

-- Ensure cache directory path is not blocked by a stale file
local cache_dir = vim.fn.stdpath 'cache' .. '/dashboard'
if vim.fn.filereadable(cache_dir) == 1 and vim.fn.isdirectory(cache_dir) == 0 then
  vim.fn.delete(cache_dir)
end

local logo = {
  [[                                                          ]],
  [[  ███████╗███████╗███╗   ███╗███╗   ███╗██╗███████╗     ]],
  [[  ██╔════╝██╔════╝████╗ ████║████╗ ████║██║██╔════╝     ]],
  [[  █████╗  █████╗  ██╔████╔██║██╔████╔██║██║█████╗       ]],
  [[  ██╔══╝  ██╔══╝  ██║╚██╔╝██║██║╚██╔╝██║██║██╔══╝       ]],
  [[  ██║     ███████╗██║ ╚═╝ ██║██║ ╚═╝ ██║██║███████╗     ]],
  [[  ╚═╝     ╚══════╝╚═╝     ╚═╝╚═╝     ╚═╝╚═╝╚══════╝     ]],
  [[                                                          ]],
}

require('dashboard').setup {
  theme = 'doom',
  config = {
    header = logo,
    center = {
      {
        icon = '󰈞  ',
        desc = 'Find File                           ',
        key = 'f',
        action = 'Telescope find_files',
      },
      {
        icon = '󰊄  ',
        desc = 'Live Grep                           ',
        key = 'g',
        action = 'Telescope live_grep',
      },
      {
        icon = '󰋚  ',
        desc = 'Recent Files                        ',
        key = 'r',
        action = 'Telescope oldfiles',
      },
      {
        icon = '󰒓  ',
        desc = 'Config                              ',
        key = 'c',
        action = 'Telescope find_files cwd=' .. vim.fn.stdpath 'config',
      },
      {
        icon = '󰒲  ',
        desc = 'Update Plugins                      ',
        key = 'u',
        action = 'lua vim.pack.update()',
      },
      {
        icon = '󰗼  ',
        desc = 'Quit                                ',
        key = 'q',
        action = 'qa',
      },
    },
    footer = {
      '',
      '⚡ Neovim initialized for FEMMIE',
    },
  },
}
