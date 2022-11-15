local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		-- filter = function(clients)
		-- filter out clients that you don't want to use
		-- return vim.tbl_filter(function(client)
		-- return client.name ~= "tsserver"
		-- end, clients)
		-- end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		--formatting binaries
		formatting.black.with({ extra_args = { "--fast" } }), -- python
		formatting.stylua, --lua
		formatting.google_java_format, -- Java

		-- linters / diagnostics binaries
		diagnostics.checkstyle.with({
			-- https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml
			extra_args = { "-c", "/google_checks.xml" },
		}),
		diagnostics.flake8, -- python
		diagnostics.shellcheck,
	},
	--on_attach = function(client, bufnr)
	--	if client.supports_method("textDocument/formatting") then
	--		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--		vim.api.nvim_create_autocmd("BufWritePre", {
	--			group = augroup,
	--			buffer = bufnr,
	--			callback = function()
	--				lsp_formatting(bufnr)
	--			end,
	--		})
	--	end
	-- end,
})
