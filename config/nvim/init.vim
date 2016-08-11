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

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


" autocomplete setup
let g:deoplete#enable_at_startup = 1


set background=dark
colorscheme gruvbox
