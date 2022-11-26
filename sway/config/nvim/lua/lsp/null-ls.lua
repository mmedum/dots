local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local status_ok_2, mason_null = pcall(require, "mason-null-ls")
if not status_ok_2 then
	return
end

local null_ls_sources = {
	"stylua",
	"ktlint",
	"hadolint",
	"black",
	"shellcheck",
	"zsh",
	"mypy",
	"flake8",
	"jq",
	"rustfmt",
	"markdownlint",
	"yamllint",
}

mason_null.setup({
	ensure_installed = null_ls_sources,
	automatic_installation = true,
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	-- Code actions
	code_actions.gitsigns, -- Git sign

	-- formatting binaries
	formatting.black.with({ extra_args = { "--fast" } }), -- Python
	formatting.stylua, -- Lua
	formatting.google_java_format, -- Java
	formatting.jq, -- Json
	formatting.rustfmt, -- Rust
	formatting.markdownlint, -- Markdown

	-- linters / diagnostics binaries
	diagnostics.checkstyle.with({ -- Java checkstyle
		-- https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml
		extra_args = { "-c", "/google_checks.xml" },
	}),
	diagnostics.mypy.with({
		prefer_local = ".venv/bin",
	}),
	diagnostics.flake8.with({ -- Python
		prefer_local = ".venv/bin",
	}),
	diagnostics.shellcheck, -- Shell
	diagnostics.zsh, -- Zsh
	diagnostics.hadolint, -- Docker
	diagnostics.ktlint, -- Kotlin
	diagnostics.markdownlint, -- Markdown
	diagnostics.yamllint, -- Yaml
}

null_ls.setup({
	debug = false,
	on_attach = require("lsp.handlers").on_attach,
	update_in_insert = true,
	sources = sources,
})
