-- python.lua
-- Auto-detect active Python virtual environment (.venv, venv, env, etc.) for Pyright & Neovim

local M = {}

--- Find python binary in active virtualenv, local directory, parent directories, or system
--- @param root_dir string|nil Optional root directory to search from
--- @return string|nil Path to python binary
function M.find_python_venv(root_dir)
  local start_dir = root_dir or vim.fn.getcwd()

  -- 1. Check if VIRTUAL_ENV environment variable is active
  if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= '' then
    local venv_bin = vim.fn.has 'win32' == 1
      and vim.fs.joinpath(vim.env.VIRTUAL_ENV, 'Scripts', 'python.exe')
      or vim.fs.joinpath(vim.env.VIRTUAL_ENV, 'bin', 'python')
    if vim.fn.executable(venv_bin) == 1 then
      return venv_bin
    end
  end

  -- 2. Search upwards from start_dir for standard virtual environment directories
  local venv_names = { '.venv', 'venv', 'env', '.env' }
  local found_venvs = vim.fs.find(venv_names, { path = start_dir, upward = true, type = 'directory' })
  if #found_venvs > 0 then
    local venv_path = found_venvs[1]
    local python_bin = vim.fn.has 'win32' == 1
      and vim.fs.joinpath(venv_path, 'Scripts', 'python.exe')
      or vim.fs.joinpath(venv_path, 'bin', 'python')

    if vim.fn.executable(python_bin) == 1 then
      return python_bin
    end
  end

  -- 3. Fallback to system python executable
  if vim.fn.executable 'python3' == 1 then
    return vim.fn.exepath 'python3'
  elseif vim.fn.executable 'python' == 1 then
    return vim.fn.exepath 'python'
  end

  return nil
end

local python_path = M.find_python_venv()
if python_path then
  vim.g.python3_host_prog = python_path
end

-- Update Pyright configuration safely when attached
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'pyright' then
      local path = M.find_python_venv(client.config and client.config.root_dir)
      if path and client.config then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, {
          python = { pythonPath = path },
        })
        pcall(function()
          client:notify('workspace/didChangeConfiguration', { settings = client.config.settings })
        end)
      end
    end
  end,
})

return M
