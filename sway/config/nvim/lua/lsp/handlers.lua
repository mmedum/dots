local M = {}
local icons = require("ui.icons")

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_lines = false,
		virtual_text = true,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "if_many", -- Or "always"
			header = "",
			prefix = "",
			-- width = 40,
		},
	}
	vim.diagnostic.config(config)

	-- Highlight on CursorHold
	vim.api.nvim_exec("autocmd CursorHold * lua vim.diagnostic.open_float()", false)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local api = vim.api
local function highlighting(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		local lsp_highlight_grp = api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
		api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.schedule(vim.lsp.buf.document_highlight)
			end,
			group = lsp_highlight_grp,
			buffer = bufnr,
		})
		api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				vim.schedule(vim.lsp.buf.clear_references)
			end,
			group = lsp_highlight_grp,
			buffer = bufnr,
		})
	end
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function formatting(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
			desc = "Format document on save with LSP",
		})
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	keymap(bufnr, "n", "dl", "<cmd>Telescope diagnostics<CR>", opts)
	keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	keymap(bufnr, "n", "dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	keymap(bufnr, "n", "dp", "<cmd>lua vim.diagnostic.goto_prev({})<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "<leader>cl", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
	keymap(bufnr, "i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	highlighting(client, bufnr)
	formatting(client, bufnr)
	lsp_keymaps(bufnr)

	-- Javaascript
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
	end
	-- Java
	if client.name == "jdtls" then
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end
end

return M
