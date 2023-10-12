set mouse=a
set clipboard=unnamed
"---------------------------------------------
"Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ervandew/supertab'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
Plug 'easymotion/vim-easymotion'

call plug#end()
"---------------------------------------------
"Colorscheme
set background=dark
syntax on
colorscheme nord
let g:airline_theme='monochrome'

let s:foreground = {'gui': '#e4e8ee', 'cterm256': '235'}
let s:white = { 'gui': '#e4e8ee', 'cterm256': '145'}
"---------------------------------------------
"Ctrlspace
"let g:CtrlSpaceDefaultMappingKey = "<C-p>"
set nocompatible
set hidden
set encoding=utf-8
set showtabline=0
"---------------------------------------------
"Shortcuts

"---------------------------------------------
"Tabs to spaces and tabwidth
set tabstop=2
set shiftwidth=2
set smarttab
set et
"---------------------------------------------
"Wrap long strings
set wrap
"---------------------------------------------
"Auto-indent
set ai
set cin
"---------------------------------------------
"Search highlights
set showmatch
set hlsearch
set incsearch
set ignorecase
"---------------------------------------------
"Airline settings
"Smart tab line
let g:airline#extensions#tabline#enabled = 1
"---------------------------------------------
"Line numbers and syntax highlighting
set nu
syntax on

"Copy macros
let @c='"+y@c'

cmap w!! w !sudo tee > /dev/null %

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
