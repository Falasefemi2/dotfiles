vim.pack.add {
  'https://github.com/nvim-pack/nvim-spectre',
  'https://github.com/nvim-lua/plenary.nvim',
}

require('spectre').setup {
  color_devicons = vim.g.have_nerd_font,
  live_update = true,
  is_insert_mode = true,
  use_trouble_qf = false,
}

vim.keymap.set('n', '<leader>rp', '<cmd>lua require("spectre").toggle()<CR>', { desc = '[R]eplace in [P]roject (Spectre)' })
vim.keymap.set('n', '<leader>rP', '<cmd>lua require("spectre").open_visual({ select_word = true })<CR>', { desc = '[R]eplace [P]roject word under cursor' })
vim.keymap.set('n', '<leader>rf', '<cmd>lua require("spectre").open_file_search({ select_word = true })<CR>', { desc = '[R]eplace in current [F]ile (Spectre)' })

local function get_selected_text()
  local old = vim.fn.getreg 'v'
  vim.fn.setreg('v', '')
  vim.cmd.normal { 'gv"vy', bang = true }
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', old)
  return text
end

local function replace_word()
  local word = vim.fn.expand '<cword>'
  if word == '' then
    vim.notify('No word under cursor', vim.log.levels.WARN)
    return
  end
  vim.cmd('%s/\\V\\<' .. vim.fn.escape(word, '/') .. '\\>/')
end

vim.keymap.set('n', '<leader>rr', replace_word, { desc = '[R]eplace word under cursor (whole file)' })

vim.keymap.set('x', '<leader>rr', function()
  local word = get_selected_text()
  word = word:gsub('^%s+', ''):gsub('%s+$', '')
  if word == '' then return end
  vim.cmd("'<,'>s/\\V\\<" .. vim.fn.escape(word, '/') .. '\\>/')
end, { desc = '[R]eplace selection text' })