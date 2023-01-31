local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "target" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
      },
      n = {
        ["<C-c>"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    lsp_references = {
      initial_mode = "normal",
    },
    buffers = {
      initial_mode = "normal",
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
    action = function(emoji)
      vim.fn.setreg("*", emoji.value)
      print([[Press p or "*p to paste this emoji]] .. emoji.value)
    end,
  },
})

telescope.load_extension("ui-select")
telescope.load_extension("emoji")
telescope.load_extension("notify")
