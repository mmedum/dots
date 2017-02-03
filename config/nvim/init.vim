if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/home/mark/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/mark/.config/nvim/dein/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-jedi')
call dein#add('itchyny/lightline.vim')
call dein#add('morhetz/gruvbox')
call dein#add('w0rp/ale')
call dein#add('derekwyatt/vim-scala')
call dein#add('Vimjas/vim-python-pep8-indent')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

""""""Python""""""
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python'

""""""Trailing whitespace""""""
" display tabs and trailing spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅"

""""""Basic""""""
let mapleader="\<SPACE>"

" Write file
nnoremap <Leader>w :w<CR>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


set noshowmode
set showmatch
set ruler
set nu
set rnu
set cursorline

set autowrite
set autoindent    " align the new line indent with the previous line
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noerrorbells
set linespace=0
set nojoinspaces

set splitbelow
set splitright
set shiftround    " round indent to multiple of 'shiftwidth'

set ai
set si

set autoread
set encoding=utf-8

set undofile
set undolevels=1000
set backupdir=~/.config/undo/
set directory=~/.config/undo/
set undodir=~/.config/undo/

inoremap jj <esc>

""""""Search""""""
set hlsearch
set ignorecase
set smartcase
set incsearch
set gdefault
set magic

nnoremap <leader>, :nohlsearch<CR>

" Search and Replace remapping
nmap <Leader>s :%s//g<Left><Left>

""""""Search and replace""""""
set inccommand=split

""""""Autocomplete setup""""""
let g:deoplete#enable_at_startup = 1

" Let <Tab> do completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


""""""Status line""""""
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }


""""""Syntax Checking""""""
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '->'

""""""Functions""""""
" http://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

""""""Color scheme""""""
set background=dark
colorscheme gruvbox
set termguicolors
