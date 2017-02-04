set number
set wrapscan
syntax on

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

execute pathogen#infect()
autocmd vimenter * NERDTree

let NERDTreeShowHidden=1

