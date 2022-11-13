local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then
  print("bufferline not ok")
  return
end

bufferline.setup{
   highlights = {
    fill = {
      bg = '#282828',
    },
  },
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      }
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
  }
}
