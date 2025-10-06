local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find('windows') ~= nil
local is_mac = wezterm.target_triple:find('apple') ~= nil
local is_linux = wezterm.target_triple:find('linux') ~= nil

config.initial_cols = 120
config.initial_rows = 48
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_frame = {
    font = wezterm.font { family = 'Fira Code' },
    font_size = 10.0,
}

config.font = wezterm.font_with_fallback {
    'Fira Code',
    'JetBrains Mono',
}

if is_windows then
    require('config.windows').apply(config)
elseif is_mac then
    config.font_size = 11
    config.default_prog = { '/bin/zsh', '-l' }
elseif is_linux then
    config.default_prog = { '/bin/bash', '-l' }
end


return config
