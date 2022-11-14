local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".git", "target" },
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		action = function(emoji)
			vim.fn.setreg("*", emoji.value)
			print([[Press p or "*p to paste this emoji]] .. emoji.value)
		end,
	},
})
