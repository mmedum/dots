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

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
local use = require("packer").use

return packer.startup(function()
	use("wbthomason/packer.nvim")

  -- Startup improvements
	use("lewis6991/impatient.nvim")

	--colorscheme
  use { "sainnhe/gruvbox-material" }

	-- UI
	use("kyazdani42/nvim-web-devicons") -- icons
	use("lukas-reineke/indent-blankline.nvim") -- enable indent  line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "kyazdani42/nvim-web-devicons" })
	use("goolord/alpha-nvim")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "p00f/nvim-ts-rainbow" }) -- enable rainbow parenthese
	use("rcarriga/nvim-notify")
  use("norcalli/nvim-colorizer.lua")
  use({ "simrat39/symbols-outline.nvim" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("xiyaowong/telescope-emoji.nvim")
	use("nvim-lua/plenary.nvim")

  -- Autoclose
	use("windwp/nvim-autopairs") -- autoclose () , {} , '' , etc

  -- Terminal
	use({ "akinsho/toggleterm.nvim" })

	-- File explorer
	use({"kyazdani42/nvim-tree.lua"}) -- enable nvimtree

	-- CMP
	use({"hrsh7th/nvim-cmp"}) -- The completion plugin
	use({"hrsh7th/cmp-buffer"}) -- buffer completions
	use({"hrsh7th/cmp-path"}) -- path completions
	use({"hrsh7th/cmp-cmdline"}) -- cmdline completions
	use({"saadparwaiz1/cmp_luasnip"}) -- snippet completions
	use({"hrsh7th/cmp-nvim-lsp"}) -- enable lsp autocomplete with cmp
	use({ "hrsh7th/cmp-nvim-lua" })

	-- LSP and DAP
	use({"neovim/nvim-lspconfig"}) -- enable LSP
	use({"jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
		"jayp0521/mason-nvim-dap.nvim",
	})
	use({ "ray-x/lsp_signature.nvim" })
	use({ "mfussenegger/nvim-dap"})
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  use({ "theHamsta/nvim-dap-virtual-text" })
	use({"mfussenegger/nvim-jdtls"})
	use({"mfussenegger/nvim-dap-python"})

	-- snippets
	use({"L3MON4D3/LuaSnip"})
	use({"rafamadriz/friendly-snippets"})

	-- Git
	use({"lewis6991/gitsigns.nvim"}) -- show git commit changes in the signcolumn

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
