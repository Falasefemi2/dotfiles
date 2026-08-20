-- ============================================================================
-- WezTerm Configuration for Windows
-- Designed for PowerShell 5.1, Oh My Posh, Neovim (kickstart.nvim), and Tmux-style Leader
-- File Location: ~/.wezterm.lua (C:\Users\FEMI\.wezterm.lua)
-- ============================================================================

local wezterm = require 'wezterm'

-- WezTerm config builder pattern (ensures type safety & version compatibility)
local config = wezterm.config_builder()

-- ----------------------------------------------------------------------------
-- 1. Default Shell Configuration
-- ----------------------------------------------------------------------------
-- Set default shell to Windows PowerShell 5.1 (powershell.exe) with -NoLogo
-- Oh My Posh prompt is automatically loaded via $PROFILE inside PowerShell
config.default_prog = { 'powershell.exe', '-NoLogo' }

-- ----------------------------------------------------------------------------
-- 2. Exit Behavior
-- ----------------------------------------------------------------------------
-- Prevent the "Process exited with code 0" popup prompt when closing panes/tabs
config.exit_behavior = 'Close'

-- ----------------------------------------------------------------------------
-- 3. Leader Key Setup (Tmux Style)
-- ----------------------------------------------------------------------------
-- Leader key set to CTRL+A with a 1000ms (1 second) timeout window
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- ----------------------------------------------------------------------------
-- 4. Typography & Font Settings
-- ----------------------------------------------------------------------------
-- Nerd Fonts required for LSP icons, blink.cmp, and neo-tree file glyphs
config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font',
  'CaskaydiaCove Nerd Font',
  'Consolas',
})
config.font_size = 11.0

-- ----------------------------------------------------------------------------
-- 5. Window Aesthetics & Acrylic Backdrop (Windows 11)
-- ----------------------------------------------------------------------------
-- High contrast theme matching Neovim kickstart setups (Catppuccin Mocha)
config.color_scheme = 'Catppuccin Mocha'

-- Transparency & Windows 11 Acrylic blur effects
config.window_background_opacity = 0.92
config.win32_system_backdrop = 'Acrylic'

-- ----------------------------------------------------------------------------
-- 6. Tab Bar Configuration
-- ----------------------------------------------------------------------------
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true

-- ----------------------------------------------------------------------------
-- 7. Custom Keybindings
-- ----------------------------------------------------------------------------
config.keys = {
  -- Leader + c: Create a new tab in the current working directory
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },

  -- Leader + %: Split pane horizontally (side-by-side)
  -- Split pane horizontally (side-by-side)
  -- Option A: Press CTRL + SHIFT + % directly
  -- Option B: Press Leader (CTRL + A) then %
  {
    key = '%',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '%',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  -- Split pane vertically (top/bottom)
  -- Option A: Press CTRL + SHIFT + " directly
  -- Option B: Press Leader (CTRL + A) then "
  {
    key = '"',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '"',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- Leader + h/j/k/l: Vim-style pane navigation
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },

  -- Leader + z: Toggle pane zoom (maximize / restore current pane)
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },

  -- Leader + x: Close current pane (prompts confirmation)
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },

  -- Leader + e: Open a new tab in project directory and automatically launch Neovim
  -- Modify the `cwd` field below to point to your target project folder.
  {
    key = 'e',
    mods = 'LEADER',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = 'C:/Users/FEMI/projects/my-project',
      args = { 'powershell.exe', '-NoLogo', '-NoExit', '-Command', 'nvim .' },
    },
  },

  -- CTRL+SHIFT+9: Fuzzy Workspace Switcher Launcher
  {
    key = '9',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
}

return config