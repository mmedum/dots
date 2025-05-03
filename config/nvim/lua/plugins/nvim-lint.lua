return {
    "mfussenegger/nvim-lint",
    config = function () 
        local lint = require("lint")

        lint.linters_by_ft = {
            lua = { "stylua" },
            yaml = { "yamllint" },
            go = { "golangcilint" },
        }
    end
}
