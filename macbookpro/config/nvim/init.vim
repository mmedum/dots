if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
"""" Mac
set runtimepath+=/Users/mark/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/mark/.cache/dein')
  call dein#begin('/Users/mark/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/mark/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('itchyny/lightline.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('w0rp/ale')
  call dein#add('Vimjas/vim-python-pep8-indent')
  call dein#add('sbdchd/neoformat')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('junegunn/fzf.vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('fatih/vim-go')
  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

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

set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c

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

""""""""vim-go"""""""
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

""""""""CoC"""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""Python""""""
let g:python_host_prog = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'

""""""YAML""""""
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

""""""Markdown""""""
" auto wrap for markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

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
            \   'left': [['mode', 'paste'], ['cocstats', 'readonly', 'filename', 'modified']],
            \   'right': [['lineinfo'], ['percent'], ['filetype', 'fileencoding', 'fileformat']]
            \ },
            \'component_function': {
            \   'cocstatus': 'coc#status'
            \ },
            \ }

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
