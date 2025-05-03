local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable arrow keys
keymap("", "<up>", "<nop>", opts)
keymap("", "<down>", "<nop>", opts)
keymap("", "<left>", "<nop>", opts)
keymap("", "<right>", "<nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Yank characters to global registr
keymap({"n", "v"}, "<leader>y", [["+y]], opts)

-- Copy from char to end of line
keymap("n", "<leader>Y", [["+Y]], opts)

-- Format entire buffer
keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

-- Clear search highlighted text
keymap("n", "<leader>,", "<cmd>nohl<CR>", opts)

-- Save file
keymap("n", "<leader>w", "<cmd>w<CR>", opts)

keymap("n", "<leader>d", "\"_d", opts)

keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Duplicate a line and comment out the first line
keymap("n", "yc", "yygccp", { remap = true, desc = "[C]opy to a comment above" })

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- visual mappings
keymap("v", "<", "<gv", opts) -- unindent lines
keymap("v", ">", ">gv", opts) -- indent lines

-- Visual Block --
keymap({ "n", "x" }, "<leader>p", [["0p]], opts) -- paste from yank register

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap('v', 'y', 'myy`y', opts)
keymap('v', 'Y', 'myY`y', opts)
