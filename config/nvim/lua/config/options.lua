local options = {
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = true, -- highlight all matches on previous search pattern
    incsearch = true, -- show where the pattern, as it was typed so far, matches
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    -- pumheight = 10, -- pop up menu height
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 0, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
    backup = false, -- do not create a backup file
    undofile = true, -- enable persistent undo
    updatetime = 50, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    laststatus = 3, -- show status lines in all windows
    showcmd = false, -- do not show command
    relativenumber = false, -- set relative numbered lines
    -- numberwidth = 2, -- set number column width to 2 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    -- sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
    title = true, -- show titles
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true, -- convert tabs to spaces
    spell = true,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
vim.opt.iskeyword:append("-,_")
