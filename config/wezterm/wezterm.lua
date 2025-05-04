local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.check_for_updates = false
config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.quit_when_all_windows_are_closed = true
config.font = wezterm.font("SauceCodePro Nerd Font")
config.font_size = 14
config.color_scheme = "Gruvbox Material (Gogh)"

return config
