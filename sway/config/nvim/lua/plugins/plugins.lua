local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path, 1)) > 0 then
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

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
local use = require("packer").use

return packer.startup(function()
	use({ "wbthomason/packer.nvim" })

	-- Startup improvements
	use({ "lewis6991/impatient.nvim" }) -- startup improvements

	--colorscheme
	use({ "sainnhe/gruvbox-material" }) -- colorscheme

	-- UI
	use({ "kyazdani42/nvim-web-devicons" }) -- icons
	use({ "lukas-reineke/indent-blankline.nvim" }) -- show indent lines
	use({
		"nvim-lualine/lualine.nvim", -- lower statusline
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({
		"akinsho/bufferline.nvim", -- upper statusline
		tag = "v3.*",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" }) -- coloring
	use({ "p00f/nvim-ts-rainbow" }) -- enable rainbow parenthese
	use({ "rcarriga/nvim-notify" }) -- notifications
	use({ "norcalli/nvim-colorizer.lua" }) -- color def
	use({ "simrat39/symbols-outline.nvim" }) -- outline symbols

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim", --
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({ "xiyaowong/telescope-emoji.nvim" }) -- emoji search
	use({ "nvim-telescope/telescope-ui-select.nvim" }) -- standard selection
	use({ "nvim-lua/plenary.nvim" })

	-- Autoclose
	use({ "windwp/nvim-autopairs" }) -- autoclosing

	-- Terminal
	use({ "akinsho/toggleterm.nvim" }) -- terminal

	-- File explorer
	use({ "kyazdani42/nvim-tree.lua" }) -- file explorer

	-- CMP
	use({ "hrsh7th/nvim-cmp" }) -- completion
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" }) -- lsp autocompletion
	use({ "hrsh7th/cmp-nvim-lua" }) -- lua completion

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) -- snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- adding snippets

	-- LSP and DAP
	use({
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",
		"jayp0521/mason-nvim-dap.nvim",
	})
	use({ "mfussenegger/nvim-dap" })
	use({
		"rcarriga/nvim-dap-ui", -- UI for debugging
		requires = { "mfussenegger/nvim-dap" },
	})
	use({ "theHamsta/nvim-dap-virtual-text" }) -- virtual text when debugging
	use({ "mfussenegger/nvim-jdtls" }) -- jdtls

	-- Gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
