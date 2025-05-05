-- https://www.josean.com/posts/neovim-linting-and-formatting
return {
    "stevearc/conform.nvim",
    enabled = true,
    tag = "stable",
    opts = {},
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                yaml = { "yamlfix" },
                lua = { "stylua" },
                sh = { "shfmt" },
                rust = { "rustfmt" },
                go = { "gofmt" },
                markdown = { "prettier" },
            },
            stop_after_first = false,
            format_on_save = {
                -- lsp_fallback = true,
                lsp_format = "fallback",
                async = false,
                timeout_ms = 1000, -- default: 1000
            },
        })
    end,
}
