""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get plugin manager if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'tpope/vim-fugitive'
Plug 'jpalardy/vim-slime'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'heavenshell/vim-pydocstring'
Plug 'vim-python/python-syntax'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'dense-analysis/ale'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard=unnamed
let g:python_highlight_all = 1
syntax on
set number
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set mouse=a
let mapleader = " "

" Tab & Indent Config
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Ignore case when searching
set ignorecase
set smartcase

" General Usability
set scrolloff=5
set autoindent

" Search will center on line if found
nnoremap n nzzzv
nnoremap N Nzzzv

" JSON formatting
command! -nargs=0 Json :exe "norm :%!jq\<Return>"

" escape from the home row
inoremap fd <ESC>
vnoremap fd <ESC>

" switch buffers
nnoremap <silent> gb :bp<CR>
nnoremap <silent> gB :bn<CR>

" Change cursor between insert and normal mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown Preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vim_markdown_preview_toggle=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dracula
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None

if exists('$TMUX')
    let g:dracula_colorterm = 0
endif

" Airline
let g:airline_theme = 'dracula'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#ale#enabled = 1

" " True Color Support
" set termguicolors

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc Nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set nowritebackup
set shortmess+=c
set signcolumn=yes

inoremap <silent> <expr><Tab>
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
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_completion_enabled              = 0
let g:ale_sign_column_always              = 1
let g:ale_fix_on_save                     = 1
let g:ale_set_quickfix                    = 1
let g:ale_virtualtext_cursor              = 1
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_linters = {
            \ 'c': ['clang', 'clangd'],
            \ 'cpp': ['clang', 'clangd'],
            \ 'python': ['flake8', 'mypy', 'pylint'],
            \ }
let g:ale_fixers = {
            \ '*': ['trim_whitespace'],
            \ 'c': ['trim_whitespace', 'clang-format', 'clangtidy'],
            \ 'cpp': ['trim_whitespace', 'clang-format', 'clangtidy'],
            \ 'go': ['trim_whitespace', 'goimports'],
            \ 'python': ['black', 'isort'],
            \ }
let g:ale_c_parse_makefile         = 0
let g:ale_c_parse_compile_commands = 1
let g:ale_c_clang_executable       = '/usr/local/opt/llvm/bin/clang'
let g:ale_c_clangd_executable      = '/usr/local/opt/llvm/bin/clangd'
let g:ale_cpp_clang_executable     = '/usr/local/opt/llvm/bin/clang'
let g:ale_cpp_clangd_executable    = '/usr/local/opt/llvm/bin/clangd'
let g:ale_c_clang_options          = '-std=c11 -Wall -Wextra -I/usr/local/include -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
let g:ale_cpp_clang_options        = '-std=c++17 -Wall -Wextra -I/usr/local/include -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
let g:ale_c_clangd_options         = '-function-arg-placeholders -all-scopes-completion -pch-storage=memory -limit-results=50 -completion-style=detailed'
let g:ale_cpp_clangd_options       = '-function-arg-placeholders -all-scopes-completion -pch-storage=memory -limit-results=50 -completion-style=detailed'
" Python Settings
let g:ale_python_black_use_global = 1
let g:ale_python_flake8_use_global = 1
let g:ale_python_pylint_use_global = 1
let g:ale_python_mypy_use_global = 1
let g:ale_python_isort_use_global = 1
let g:ale_python_black_executable = '/usr/local/bin/black'
let g:ale_python_flake8_executable = '/usr/local/bin/flake8'
let g:ale_python_pylint_executable = '/usr/local/bin/pylint'
let g:ale_python_mypy_executable = '/usr/local/bin/mypy'
let g:ale_python_isort_executable = '/usr/local/bin/isort'
let g:ale_python_flake8_options    = '--max-line-length=120'
let g:ale_python_black_options     = '--line-length 120'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go Settings
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

au FileType sql setl formatprg=/usr/local/bin/pg_format\ -

" Map toggle
nnoremap <LEADER>pg <ESC>gq<S-G>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = {'down': '20%'}

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
" vim-slime
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
