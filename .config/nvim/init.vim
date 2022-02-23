"====================================
"general
"====================================

colorscheme pablo

syntax on

"enable mouse
set mouse=a

"line numbers
set number
set relativenumber

"tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"search options
set ignorecase
set smartcase

"disable write buffer backup
set nobackup
set nowritebackup
set noswapfile

"foldlevel
set foldlevelstart=99

"allow buffer modification
set modifiable

"use y and p with system clipboard
set clipboard=unnamedplus

"set blinkon for all cursors
"a=all, n=normal, v=visual, c=command, i=insert
set guicursor+=a:blinkon1

"====================================
"plugins
"====================================

call plug#begin()

"Buffer navigation
Plug 'vim-airline/vim-airline'

call plug#end()

