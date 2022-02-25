" ================================================= "
" d8888b.  .d88b.  db       .d8b.  d8888b. .d8888.  "
" 88  `8D .8P  Y8. 88      d8' `8b 88  `8D 88'  YP  "
" 88oodD' 88    88 88      88ooo88 88oobY' `8bo.    "
" 88~~~   88    88 88      88~~~88 88`8b     `Y8b.  "
" 88      `8b  d8' 88booo. 88   88 88 `88. db   8D  "
" 88       `Y88P'  Y88888P YP   YP 88   YD `8888Y'  "
" ================================================= "
  
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

"Telescope dependecies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"File browser
Plug 'nvim-telescope/telescope-file-browser.nvim'

call plug#end()


"====================================
"keybinds
"====================================
let mapleader="\<SPACE>"

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fu <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>fb <cmd>lua require 'telescope'.extensions.file_browser.file_browser()<cr>
