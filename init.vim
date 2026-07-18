""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" System clipboard
set clipboard+=unnamedplus

" Enable vim features
set nocompatible

" Filetype detection, plugins, and indent
filetype plugin indent on

" Automatically read changed file
set autoread

" Persistent Undo
set undodir=$HOME/.vim/undodir
set undofile

" Don't wrap lines
set nowrap

" No swap files
set noswapfile

" Show line numbers (relative + absolute on current line)
set number relativenumber

" Encodings
set encoding=utf-8
set fileencoding=utf-8

" Fix backspace
set backspace=indent,eol,start

" Enable the mouse
set mouse=a

" Tabs & Indents
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set scrolloff=5
set autoindent

" Highlight current line
set cursorline

" New splits will be at bottom or to the right
set splitbelow
set splitright

" Visual autocomplete for command menu
set wildmenu

" Highlight matching brackets, parens, etc.
set showmatch

" Syntax highlighting
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set incsearch
set ignorecase
set smartcase

" Search will center on line if found
nnoremap n nzzzv
nnoremap N Nzzzv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Handy Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap leader
let mapleader = " "

" Remap escape key
inoremap fd <ESC>
vnoremap fd <ESC>

" Switch buffers
nnoremap <silent> gb :bp<CR>
nnoremap <silent> gB :bn<CR>

" Visual Mode Indenting
vnoremap < <gv
vnoremap > >gv

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup filetype_indent
    autocmd!
    au BufRead,BufNewFile *.yml setfiletype yaml
    au FileType yaml,json,html,xml,typescript,javascript,c,cpp
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2
    au FileType make setlocal noexpandtab
    au FileType go setlocal noexpandtab tabstop=8 shiftwidth=8
    au FileType markdown setlocal wrap
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw (built-in file explorer)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
nmap <LEADER>vv :Vexplore<CR>
autocmd FileType netrw setl bufhidden=delete
