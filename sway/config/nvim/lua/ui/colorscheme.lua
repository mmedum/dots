local colorscheme = "gruvbox-material"

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_italic = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	print("gruvbox-material not ok")
	return
end
