local api = vim.api

-- Do not auto comment new line
local comment_group = api.nvim_create_augroup("AutoComment", { clear = true })
api.nvim_create_autocmd("BufEnter", {
	group = comment_group,
	desc = "Do not auto comment new line",
	pattern = "*",
	command = [[set formatoptions-=cro]],
})

-- Enable spell on filetypes
local spell_group = api.nvim_create_augroup("SpellChecking", { clear = true })
api.nvim_create_autocmd({ "FileType" }, {
	group = spell_group,
	desc = "Enable spell check on filetypes",
	pattern = { "markdown", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- Turn off paste mode when leaving insert
local pasteinsert_group = api.nvim_create_augroup("DisablePasteLeavingInsert", { clear = true })
api.nvim_create_autocmd("InsertLeave", {
	group = pasteinsert_group,
	desc = "Leave paste mode when leaving insert",
	pattern = "*",
	command = "set nopaste",
})

-- Go to last location of buffer
local location_group = api.nvim_create_augroup("LastLocationBuffer", { clear = true })
api.nvim_create_autocmd("BufReadPost", {
	group = location_group,
	desc = "Go to last location of buffer",
	pattern = "*",
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

-- Highlight on yank
local yank_group = api.nvim_create_augroup("HighlightYank", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
	end,
})

-- Hightlight cursorline only in current buffer
local cursor_group = api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
	api.nvim_create_autocmd(event, {
		group = cursor_group,
		desc = "Highlight cursor line in current buffer",
		pattern = pattern,
		callback = function()
			vim.opt_local.cursorline = value
		end,
	})
end

-- Auto linting with nvim-lint
local lint_group = api.nvim_create_augroup("Lint", { clear = true })
api.nvim_create_autocmd({ "BufWritePost" }, {
            group = lint_group,
    desc = "Lint with nvim-lint psot buf write",
    pattern = "*",
    callback = function()
        require("lint").try_lint()
    end,
})
