local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then
	print("bufferline not ok")
	return
end

bufferline.setup({
	highlights = {
		fill = {
			bg = "#282828",
		},
	},
	options = {
		mode = "tabs",
		diagnostics = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				padding = 1,
			},
		},
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = false,
		separator_style = "thin",
		enforce_regular_tabs = true,
	},
})
