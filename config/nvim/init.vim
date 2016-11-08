if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/home/mark/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/home/mark/.config/nvim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/deoplete.nvim')
call dein#add('itchyny/lightline.vim')
call dein#add('morhetz/gruvbox')
call dein#add('neomake/neomake')
call dein#add('zchee/deoplete-jedi')
call dein#add('artur-shaik/vim-javacomplete2')

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


""""""Basic""""""
let mapleader="\<SPACE>"

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk

set noshowmode
set showmatch
set ruler
set nu
set rnu
set cursorline
set expandtab           
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noerrorbells 
set linespace=0 
set splitbelow
set splitright  

set ai
set si

set autoread
set encoding=utf-8

set backupdir=~/.config/nvimbackup//
set directory=~/.config/nvimbackup//
set undodir=~/.config/nvimbackup//

inoremap jj <esc>

""""""Search""""""
set hlsearch
set ignorecase
set smartcase
set incsearch  
set gdefault
set magic

nnoremap <leader>, :nohlsearch<CR>

""""""Autocomplete setup""""""
let g:deoplete#enable_at_startup = 1

" Let <Tab> do completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set autocompletion for java to vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete



""""""Status line""""""
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }


""""""Syntax Checking""""""
autocmd! BufWritePost,BufEnter * Neomake

let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

""""""Functions""""""
" http://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

""""""Color scheme""""""
set background=dark
colorscheme gruvbox


