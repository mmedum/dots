local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "gruvbox-material",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_divide_middle = true,
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",
				colored = true, -- Displays a colored diff status if set to true
				diff_color = {
					-- Same color values as the general color option can be used here.
					added = "DiffAdd", -- Changes the diff's added color
					modified = "DiffChange", -- Changes the diff's modified color
					removed = "DiffDelete", -- Changes the diff's removed color you
				},
				symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
				source = nil, -- A function that works as a data source for diff.
				-- It must return a table as such:
				--   { added = add_count, modified = modified_count, removed = removed_count }
				-- or nil on failure. count <= 0 won't be displayed.
			},
		},
		lualine_c = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn", "info", "hint" },
				colored = true,
				update_in_insert = true,
			},
		},
		lualine_x = {
			"filename",
			"encoding",
			{
				"fileformat",
				symbols = {
					unix = "unix",
					dos = "win",
					mac = "mac",
				},
			},
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = {
			"location",
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree" },
})
