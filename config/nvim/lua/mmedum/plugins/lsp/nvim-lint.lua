return {
    "mfussenegger/nvim-lint",
    -- event = { "BufReadPre", "BufNewFile" },
    event = "VeryLazy",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            go = { "golangcilint" },
        }

        -- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWritePost", "InsertLeave" }, {
            -- group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
