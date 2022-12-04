local buffer_status_ok, bufferline = pcall(require, "bufferline")
if not buffer_status_ok then
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
		numbers = "ordinal",
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "Tree",
				padding = 1,
			},
		},
		color_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = false,
		separator_style = "thin",
		enforce_regular_tabs = true,
	},
})
