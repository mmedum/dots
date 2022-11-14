require("plugins.plugins")
require("plugins.impatient")
require("plugins.nvim-tree")
require("plugins.autopairs")
require("plugins.colorizer")
require("plugins.symbols-outline")
require("plugins.dap")
require("plugins.indent-blankline")
require("plugins.nvim-notify")

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.load_extension("emoji")
