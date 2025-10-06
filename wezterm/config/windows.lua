local wezterm = require 'wezterm'
local M = {}

function M.apply(config)
    config.font_size = 11

    config.default_prog = { 'wsl.exe', '-d', 'Debian', '--cd', '~' }
    config.launch_menu = {
        {
            label = 'WSL Debian',
            args = { 'wsl.exe', '-d', 'Debian', '--cd', '~' },
        },
        {
            label = 'PowerShell',
            args = { 'powershell.exe', '-NoLogo' },
        },
        {
            label = 'PowerShell [Admin]',
            args = { 'gsudo.exe', 'powershell.exe', '-NoLogo' },
        },
        {
            label = 'CMD',
            args = { 'cmd.exe' },
        },
    }
    
    config.keys = {
        {
            key = 'l',
            mods = 'ALT',
            action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' }
        },
        {
            key = 'c',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.CopyTo 'Clipboard'
        },
        {
            key = 'v',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.PasteFrom 'Clipboard'
        },
    }
end

return M
