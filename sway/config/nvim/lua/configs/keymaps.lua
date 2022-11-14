local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c"

--Remap space as leader key
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

-- Clear search highlighted text
keymap("n", "<leader>,", "<cmd>nohl<CR>", opts)

-- Save file
keymap("n", "<Space>w", "<cmd>w<CR>", opts)

-- Tabs
keymap("n", "<leader>1", "1gt", opts)
keymap("n", "<leader>2", "2gt", opts)
keymap("n", "<leader>3", "3gt", opts)
keymap("n", "<leader>4", "4gt", opts)
keymap("n", "<leader>5", "5gt", opts)
keymap("n", "<leader>6", "6gt", opts)
keymap("n", "<leader>7", "7gt", opts)
keymap("n", "<leader>8", "8gt", opts)
keymap("n", "<leader>9", "9gt", opts)
-- Creation and closing of tabs
keymap("n", "<leader>tc", "<cmd>tabnew<CR>", opts)
keymap("n", "<leader>tq", "<cmd>tabclose!<CR>", opts)
-- Move between tabs
keymap("n", "<leader>tn", "<cmd>tabnext<CR>", opts)
keymap("n", "<leader>tp", "<cmd>tabprevious<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Nvim-tree
keymap("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Visual --
-- visual mappings
keymap("v", "<", "<gv", opts) -- unindent lines
keymap("v", ">", ">gv", opts) -- indent lines

keymap("v", "p", "_dP", opts) --"paste"  in visual mode replace selected text with the yanked text

-- Tools ---
-- Telescope mappings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", opts)
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", opts)
-- keymap("i", "<C-e>", "<cmd>Telescope emoji<CR>", opts)
-- keymap("n", "<C-e>", "<cmd>Telescope emoji<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle({reset=true})<cr>", opts)

-- Term --
-- ToggleTerm mappings
--keymap("t", "<C-q>", [[<C-\><C-n>]], opts)
--keymap("n", "<C-r><C-a>", "<cmd>lua _ranger_toggle()<CR>", opts)
----keymap("n", "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<CR>", opts)
--keymap("t", "<C-r><C-a>", "<cmd>lua _ranger_toggle()<CR>", opts)
--keymap("t", "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<CR>", opts)
--keymap("t", "<C-A-Left>", "<cmd>wincmd h<CR>", opts)
--keymap("t", "<C-A-Down>", "<cmd>wincmd j<CR>", opts)
--keymap("t", "<C-A-Up>", "<cmd>wincmd k<CR>", opts)
--keymap("t", "<C-A-Right>", "<cmd>wincmd l<CR>", opts)
--
--tools
--keymap("n", "<C-o>", "<cmd> SymbolsOutline<CR>", opts)
--keymap("n", "<leader>ch", "<cmd>noh<cr>", opts)
--keymap("n", "<leader>ct", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)
--keymap("n", "<leader>r", "<Plug>RestNvim", opts)
--keymap("n", "<leader>rp", "<Plug>RestNvimPreview", opts)
--keymap("n", "<leader>rl", "<Plug>RestNvimLast", opts)
--keymap("n", "<leader>db", "<cmd>DBUIToggle<cr>", opts)
--
--keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", fopts)
--
---- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
--keymap("n", "<C-n>", "<cmd> BufferLineCycleNext<CR>", opts)
--keymap("n", "<C-p>", "<cmd> BufferLineCyclePrev<CR>", opts)
--
---- Buffer navigation
--keymap("n", "<C-m><C-n>", "<cmd> BufferLineMoveNext<CR>", opts)
--keymap("n", "<C-m><C-p>", "<cmd> BufferLineMovePrev<CR>", opts)
--
--
--keymap("n", "<C-p><C-e>", '"*p', opts)
--
----Gitsigns
--keymap("n", "<leader>gs", "<cmd> Gitsigns show<CR>", opts)
--keymap("n", "<leader>gt", "<cmd> Gitsigns toggle_deleted<CR>", opts)
--keymap("n", "<leader>gd", "<cmd> Gitsigns diffthis<CR>", opts)
--
--
---- Packer
--keymap("n", "<leader>ps", "<cmd>PackerSync<cr>", opts)
--
---- Move lines
---- Normal-mode commands
--keymap("n", "<A-j>", ":MoveLine(1)<CR>", opts)
--keymap("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
--keymap("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
--keymap("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
--
---- Visual-mode commands
--keymap("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
--keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
--keymap("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
--keymap("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
--
---- Translator
--keymap("n", "<C-t>", "<cmd>Pantran<CR>", opts)
--
---- Harpoon
--keymap("n", "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
--keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
--keymap("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
--keymap("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
--keymap("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
--keymap("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
--keymap("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", opts)
--keymap("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opts)
--
---- unmapping
--keymap("n", "<C-z>", "", fopts)
--pdlu
