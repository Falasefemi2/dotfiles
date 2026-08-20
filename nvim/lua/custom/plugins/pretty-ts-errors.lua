vim.pack.add { 'https://github.com/youyoumu/pretty-ts-errors.nvim' }
require('pretty-ts-errors').setup {}

vim.keymap.set('n', '<leader>de', function() require('pretty-ts-errors').show_formatted_error() end, { desc = 'Show TS error' })
vim.keymap.set('n', '<leader>dE', function() require('pretty-ts-errors').open_all_errors() end, { desc = 'Show all TS errors' })
vim.keymap.set('n', '<leader>dt', function() require('pretty-ts-errors').toggle_auto_open() end, { desc = 'Toggle TS error auto-display' })
