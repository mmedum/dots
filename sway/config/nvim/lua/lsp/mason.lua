local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local status_ok_2, mason_null = pcall(require, "mason-null-ls")
if not status_ok_2 then
	return
end

local status_ok_3, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not status_ok_3 then
	return
end

local servers = {
	"jdtls",
	"jsonls",
	"sumneko_lua",
	"bashls",
	"yamlls",
	"rust_analyzer",
}

local debuggers = {
	"javatest",
	"javadbg",
}

local null_ls_sources = {
	"stylua",
	"ktlint",
	"hadolint",
	"markdownlint",
	"black",
	"shellcheck",
	"yamllint",
	"zsh",
	"flake8",
	"jq",
	"rustfmt",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}
mason.setup(settings)

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

mason_nvim_dap.setup({
	ensure_installed = debuggers,
	automatic_installation = true,
})

mason_null.setup({
	ensure_installed = null_ls_sources,
	automatic_installation = true,
})

-- LSP setup
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

-- Filter function, used for setting up more specific LSP settings
for _, server in pairs(servers) do
	opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		-- Setup with extra options
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		lspconfig.sumneko_lua.setup(sumneko_opts)
		goto continue
	end

	if server == "jdtls" then
		-- Do not setup Java, since we already have defined everything in java.lua
		goto continue
	end

	-- Setup all other servers
	lspconfig[server].setup(opts)
	::continue::
end
