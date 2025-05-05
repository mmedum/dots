-- status line like vim-airline

-- Display attached LSP client
local function lsp_client_name()
    -- local bufnr = vim.api.nvim_get_current_buf()

    -- local clients = vim.lsp.buf_get_clients(bufnr)
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
        return "n/a"
    end

    local c = {}
    for _, client in pairs(clients) do
        table.insert(c, client.name)
        -- table.insert(c, string.sub(client.name, 0, 8) .. "...")
    end
    return "\u{f085} " .. table.concat(c, ",")
end

-- hide content on narrow windows
local function hide_in_width()
    return vim.fn.winwidth(0) > 80
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPre", "BufNewFile" },

    opts = {
        theme = "gruvbox-material",
        sections = {
            lualine_a = {
                {
                    -- shorten mode names
                    -- https://github.com/nvim-lualine/lualine.nvim/issues/614#issuecomment-1072275099
                    "mode",
                    fmt = function(res)
                        return res:sub(1, 1)
                    end,
                },
            },
            lualine_c = {
                {
                    "buffers",
                    show_filename_only = true,
                },
            },
            lualine_x = {
                -- specify full list of elements when adding custom things
                { "encoding",      cond = hide_in_width },
                { "fileformat",    cond = hide_in_width },
                { "filetype" },
                { lsp_client_name, cond = hide_in_width },
            },
        },
    },
}
