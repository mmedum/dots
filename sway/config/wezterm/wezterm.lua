local status_ok, wezterm = pcall(require, "wezterm")
if not status_ok then
	return
end

return {
	font = wezterm.font({
		family = "Hasklug Nerd Font",
		harfbuzz_features = { "liga=1" },
	}),
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = false,
	font_size = 12,
	color_scheme = "GruvboxDark (Gogh)",
	colors = require("colors"),
	window_frame = {
		-- The font used in the tab bar.
		-- Roboto Bold is the default; this font is bundled
		-- with wezterm.
		-- Whatever font is selected here, it will have the
		-- main font setting appended to it to pick up any
		-- fallback fonts you may have used there.
		font = wezterm.font({ family = "Hasklug Nerd Font" }),
		font_size = 11.0,
		inactive_titlebar_bg = "#282828",
		active_titlebar_bg = "#282828",
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}
