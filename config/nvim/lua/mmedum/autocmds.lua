local api = vim.api

-- LSP attach setup
api.nvim_create_autocmd("LspAttach", {
    group = api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method("textDocument/implementation") then
            -- Create a keymap for vim.lsp.buf.implementation ...
        end
        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method("textDocument/completion") then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}
            -- for i = 32, 126 do
            --     table.insert(chars, string.char(i))
            -- end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars
            -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if
            not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting")
        then
            api.nvim_create_autocmd("BufWritePre", {
                group = api.nvim_create_augroup("my.lsp", { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

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
