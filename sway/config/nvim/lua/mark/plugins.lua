local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Do not error out on first run
local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Autosync packer when plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use { "lewis6991/impatient.nvim", config = [[require("impatient")]] } -- Startup improvments    

  use { "wbthomason/packer.nvim" } -- Let packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua function in nvim
  use { "kyazdani42/nvim-web-devicons" } -- File icons
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter

  -- Colorscheme
  use { "sainnhe/gruvbox-material" } -- Gruvbox material colorscheme

  -- File explorer
  use { "kyazdani42/nvim-tree.lua" }

  -- Cmp
  use { "hrsh7th/nvim-cmp" } -- Completion plugin 
  use { "hrsh7th/cmp-buffer" } -- Buffer completions
  use { "hrsh7th/cmp-path" } -- Path completions
  use { "hrsh7th/cmp-cmdline" } -- Cmd completions
  use { "saadparwaiz1/cmp_luasnip" } -- Snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }

  -- Snippets
  use { "L3MON4D3/LuaSnip" } -- Snippet engine
  use { "rafamadriz/friendly-snippets" } -- Useful snippets

  -- Lsp
  use { "jose-elias-alvarez/null-ls.nvim" }
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" } -- simple to use language server installer
  use { "williamboman/mason-lspconfig.nvim" } -- simple to use language server installer 

  -- Telescope
  use { "nvim-telescope/telescope.nvim" } -- Telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }

  -- Lualine
  use { "nvim-lualine/lualine.nvim" }

  -- Tabline
  use { "nanozuki/tabby.nvim" }

  -- Bufferline
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  -- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
