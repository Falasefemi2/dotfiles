vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }

local toggleterm = require 'toggleterm'
local Terminal = require('toggleterm.terminal').Terminal

toggleterm.setup {
  direction = 'float',
  hide_numbers = true,
  shade_terminals = true,
  persist_size = true,
  persist_mode = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  float_opts = {
    border = 'curved',
    width = function() return math.floor(vim.o.columns * 0.9) end,
    height = function() return math.floor(vim.o.lines * 0.8) end,
    winblend = 0,
  },
}

local terminals = {}
local active_id = 1

local function terminal_name(id)
  return ('Terminal %d'):format(id)
end

local function terminal_ids()
  local ids = {}
  for id in pairs(terminals) do
    table.insert(ids, id)
  end
  table.sort(ids)
  return ids
end

local function next_terminal_id()
  local max_id = 0
  for id in pairs(terminals) do
    max_id = math.max(max_id, id)
  end
  return max_id + 1
end

local function get_terminal(id)
  if not terminals[id] then
    terminals[id] = Terminal:new {
      id = id,
      display_name = terminal_name(id),
      direction = 'float',
      hidden = true,
      close_on_exit = false,
    }
  end

  return terminals[id]
end

local function toggle_terminal(id)
  active_id = id or active_id
  get_terminal(active_id):toggle()
end

local function new_terminal()
  local id = next_terminal_id()
  active_id = id
  get_terminal(id):toggle()
end

local function switch_terminal(step)
  local ids = terminal_ids()
  if #ids == 0 then
    new_terminal()
    return
  end

  local index = 1
  for i, id in ipairs(ids) do
    if id == active_id then
      index = i
      break
    end
  end

  active_id = ids[((index - 1 + step) % #ids) + 1]
  toggle_terminal(active_id)
end

local function select_terminal()
  local ids = terminal_ids()
  if #ids == 0 then
    new_terminal()
    return
  end

  local choices = {}
  for index, id in ipairs(ids) do
    choices[index] = terminal_name(id)
  end

  vim.ui.select(choices, { prompt = 'Open terminal' }, function(choice, index)
    if not choice then return end
    toggle_terminal(ids[index])
  end)
end

local function close_terminal()
  local term = terminals[active_id]
  if not term then return end

  term:shutdown()
  terminals[active_id] = nil

  local ids = terminal_ids()
  active_id = ids[1] or 1
end

vim.keymap.set({ 'n', 't' }, '<C-\\>', function() toggle_terminal(active_id) end, { desc = 'Toggle terminal' })
vim.keymap.set('n', '<leader>tt', function() toggle_terminal(active_id) end, { desc = 'Toggle terminal' })
vim.keymap.set('n', '<leader>tn', new_terminal, { desc = 'New terminal' })
vim.keymap.set('n', '<leader>ts', select_terminal, { desc = 'Select terminal' })
vim.keymap.set('n', '<leader>t]', function() switch_terminal(1) end, { desc = 'Next terminal' })
vim.keymap.set('n', '<leader>t[', function() switch_terminal(-1) end, { desc = 'Previous terminal' })
vim.keymap.set('n', '<leader>tq', close_terminal, { desc = 'Close terminal' })

for id = 1, 9 do
  vim.keymap.set('n', ('<leader>t%d'):format(id), function() toggle_terminal(id) end, { desc = ('Terminal %d'):format(id) })
end
