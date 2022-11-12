local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("lspconfig not ok")
  return
end

require "mark.lsp.mason"
require("mark.lsp.handlers").setup()
require "mark.lsp.null-ls"
