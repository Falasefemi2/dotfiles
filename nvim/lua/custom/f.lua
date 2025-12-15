-- Helper functions module
local M = {}

-- fn: wraps a function to be used in keymaps
-- This allows you to call Lua functions directly in keymaps
function M.fn(func, opts)
  opts = opts or {}
  return function()
    return func(opts)
  end
end

return M
