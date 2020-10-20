""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get plugin manager if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
 Filessilent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Cosmetic
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'vim-python/python-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
" Language Servers
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hashivim/vim-terraform'
" Utils
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Yank into system clipboard
set clipboard=unnamed

" Show line numbers
set number

" Encodings
set encoding=utf-8
set fileencoding=utf-8

" Fix backspace
set backspace=indent,eol,start

" Enable the mouse
set mouse=a

" Tabs & Indents
set tabstop=4
set softtabstop=0
set shiftwidth=4
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set hlsearch
set incsearch

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

" Rurn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enhanded python highlighting (needs to be before syntax)
let g:python_highlight_all = 1

" Syntax highlighting
syntax on

" C++ Enhanced Highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dracula
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None

if exists('$TMUX')
    let g:dracula_colorterm = 0
endif

" Airline
let g:airline#extensions#coc#enabled = 1
let g:airline_theme = 'dracula'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc Nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <silent> <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-p>"
inoremap <silent> <expr> <C-Space> coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" use `:Sort` for organize python imports isort
command! -nargs=0 Sort :call CocAction('runCommand', 'python.sortImports'

" auto close scratch/preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GO
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_highlight_functions         = 1
let g:go_highlight_function_calls    = 1
let g:go_highlight_methods           = 1
let g:go_highlight_types             = 1
let g:go_highlight_fields            = 1
let g:go_highlight_operators         = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags     = 1
let g:go_highlight_debug             = 1
let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup yaml_files
    autocmd!
    au BufRead,BufNewFile *.yml setfiletype yaml
    au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup make_files
    autocmd!
    au FileType make setlocal noexpandtab
augroup END

augroup docker_files
    autocmd!
    au BufRead,BufNewFile Dockerfile.* set syntax=Dockerfile
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:fzf_layout = {'down': '25%'}

let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

" search filenames
nmap <LEADER>ff :Files <CR>

" search tags in current buffer
nmap <LEADER>ft :BTags <CR>

" search tags in the project
nmap <LEADER>fT :Tags <CR>

" search lines in current buffer
nmap <LEADER>fl :BLines <CR>

" search lines in loaded buffers
nmap <LEADER>fL :Lines <CR>

" ripgrep search results
nmap <LEADER>fr :Rg <CR>

" another alias for ripgrep
nmap <LEADER>rg :Rg <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20 

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Vexplore
augroup END

" Unbind <C-l> so it doesn't interfere with split navigation
nmap <LEADER>rr <Plug>NetrwRefresh

" Shortcut Vexplore
nmap <LEADER>vv :Vexplore<CR>

" Delete netrw buffer once it's hidden
autocmd FileType netrw setl bufhidden=delete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc Utils
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JSON formatting
command! -nargs=0 Json :exe "norm :%!jq\<Return>"

" Terraform autoformat
let g:terraform_fmt_on_save = 1
