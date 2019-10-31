if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/mark/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/mark/.cache/dein')
  call dein#begin('/Users/mark/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/mark/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('deoplete-plugins/deoplete-go', {'build': 'make'})
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('itchyny/lightline.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('w0rp/ale')
  call dein#add('psf/black')
  call dein#add('sbdchd/neoformat')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('junegunn/fzf.vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('fatih/vim-go')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

""""""Basic""""""
let mapleader="\<SPACE>"

set path=$PWD/**

set mouse=a

let g:tex_flavor = "latex"

" auto wrap for markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

" Write file
nnoremap <Leader>w :w<CR>
" Quit file
noremap <leader>q :q<cr>

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
set nu
set cursorline

set autowrite
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noerrorbells
set nojoinspaces

set splitbelow
set splitright
set shiftround    " round indent to multiple of 'shiftwidth'

set autoread
set encoding=utf-8

set undofile
set undolevels=1000
set backupdir=~/.config/undo/
set directory=~/.config/undo/
set undodir=~/.config/undo/

inoremap jk <esc>

""""""Deoplete"""""
let g:deoplete#enable_at_startup = 1

""""""Python""""""
let g:python_host_prog = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'

autocmd BufWritePre *.py execute ':Black'

""""""Golang""""""
let g:go_fmt_command = 'goimports'
let g:go_list_type = 'quickfix'
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_list_autoclose = 1
let g:go_gocode_unimported_packages = 1 

let g:deoplete#sources#go#gocode_binary = $HOME.'/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#source_importer = 1

""""""Trailing whitespace""""""
" display tabs and trailing spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅"

""""""Search""""""
set hlsearch
set ignorecase
set smartcase
set incsearch
set gdefault
set magic

nnoremap <leader>, :nohlsearch<CR>

""""""Search and replace""""""
set inccommand=split

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


""""""Status line""""""
let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
            \   'right': [['lineinfo'], ['percent'], ['filetype', 'fileencoding', 'fileformat'], ['linter_warnings', 'linter_errors', 'linter_ok']]
            \ },
            \ 'component_expand': {
            \   'linter_warnings': 'LightlineLinterWarnings',
            \   'linter_errors': 'LightlineLinterErrors',
            \   'linter_ok': 'LightlineLinterOK'
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error'
            \ },
            \ }
function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ', all_errors)
endfunction
function! LightlineLinterOK() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
    if exists('#lightline')
        call lightline#update()
    end
endfunction

""""""Neoformat""""""
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

""""""Syntax Checking""""""
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_sign_error = ''
let g:ale_sign_warning = ''

""""""FZF""""""
" Enable fzf through zplugin installation
set rtp+=/usr/local/opt/fzf

nnoremap <leader>o :FZF -m<cr>  
nnoremap <leader>r :FZF -m ~<cr>  

""""""Functions""""""
" http://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

""""""Color scheme""""""
set background=dark
colorscheme gruvbox
set termguicolors
