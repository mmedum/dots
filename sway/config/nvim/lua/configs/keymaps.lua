local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

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
keymap("n", "<leader>tt", "<cmd>tabnew<CR>", opts)
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
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", opts)
-- keymap("i", "<C-e>", "<cmd>Telescope emoji<CR>", opts)
-- keymap("n", "<C-e>", "<cmd>Telescope emoji<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle({reset=true})<cr>", opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		keymap("n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
		keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
		keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
		keymap("n", "dl", "<cmd>Telescope diagnostics<CR>", opts)
		keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
		keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
		keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev({})<CR>", opts)
		keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		keymap("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
		keymap("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		keymap("n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		--keymap("n", "<leader>oa", vim.lsp.buf.add_workspace_folder, opts)
		--keymap("n", "<leader>or", vim.lsp.buf.remove_workspace_folder, opts)
		--keymap("n", "<leader>ol", function()
		--	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		--end, opts)
		--vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	end,
})

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
---- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
--keymap("n", "<C-n>", "<cmd> BufferLineCycleNext<CR>", opts)
--keymap("n", "<C-p>", "<cmd> BufferLineCyclePrev<CR>", opts)
--
---- Buffer navigation
--keymap("n", "<C-m><C-n>", "<cmd> BufferLineMoveNext<CR>", opts)
--keymap("n", "<C-m><C-p>", "<cmd> BufferLineMovePrev<CR>", opts)
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
---- Harpoon
--keymap("n", "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
--keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
--keymap("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
--keymap("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
--keymap("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
--keymap("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
--keymap("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", opts)
--keymap("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opts)
