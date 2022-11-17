local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	notify_format = "[null-ls] %s",
	debug = false,
	sources = {
		--formatting binaries
		formatting.black.with({ extra_args = { "--fast" } }), -- Python
		formatting.stylua, -- Lua
		formatting.google_java_format, -- Java
		formatting.markdownlint, -- Markdown
		formatting.jq, -- Json
		formatting.rustfmt, -- Rust

		-- linters / diagnostics binaries
		diagnostics.checkstyle.with({ -- Java checkstyle
			-- https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml
			extra_args = { "-c", "/google_checks.xml" },
		}),
		diagnostics.flake8, -- Python
		diagnostics.shellcheck, -- Shell
		diagnostics.yamllint, -- Yaml
		diagnostics.zsh, -- Zsh
	},
})
