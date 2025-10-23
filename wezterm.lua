local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.keys = {
  { key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
}

config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}

local onedark = wezterm.color.get_builtin_schemes()['One Dark (Gogh)']
onedark.foreground = '#c9cdd5'

config.color_schemes = {
    ['One Dark (Patched)'] = onedark,
}

config.color_scheme = 'One Dark (Patched)'
-- config.color_scheme = 'Catppuccin Mocha (Gogh)'

config.font = wezterm.font {
    family = 'MesloLGS NF',
}

config.font_size = 14.0
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.default_prog = { 'tmux', 'new-session', '-A', '-s', 'Main' }
config.audible_bell = "Disabled"
config.disable_default_key_bindings = true
config.warn_about_missing_glyphs = false
config.adjust_window_size_when_changing_font_size = false

return config
