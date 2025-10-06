local wezterm = require 'wezterm'
local M = {}

function M.apply(config)
    config.font_size = 12

    config.default_prog = { '/bin/zsh', '-l' }

    config.keys = {
      -- Split vertically (left/right)
      {
        key = 'd',
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
      },
      -- Split horizontally (top/bottom)
      {
        key = 'd',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
      },
      -- Navigate panes
      {
        key = 'h',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Left',
      },
      {
        key = 'l',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Right',
      },
      {
        key = 'k',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Up',
      },
      {
        key = 'j',
        mods = 'CMD',
        action = wezterm.action.ActivatePaneDirection 'Down',
      },
      -- Close pane
      {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.CloseCurrentPane { confirm = true },
      },
    }
end

return M
