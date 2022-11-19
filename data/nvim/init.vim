set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nohlsearch
set hidden
set noerrorbells
set nowrap
set scrolloff=8

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

lua require('nvim-tree').setup()

colorscheme jellybeans
highlight Normal ctermbg=none

let mapleader = " "
nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>s <cmd>Telescope git_status<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>
nnoremap <leader>g <cmd>NvimTreeToggle<cr>
nnoremap <C-w> <cmd>bdelete<cr>
nnoremap <leader>h <cmd>wincmd h<cr>
nnoremap <leader>j <cmd>wincmd j<cr>
nnoremap <leader>k <cmd>wincmd k<cr>
nnoremap <leader>l <cmd>wincmd l<cr>
