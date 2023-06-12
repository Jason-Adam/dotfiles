""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/site/autoload')

" Cosmetic
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', {'as': 'dracula'}

" Language Servers & Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ziglang/zig.vim'

" VIM slime
Plug 'jpalardy/vim-slime', { 'branch': 'main' }

" Utils
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Github Copilot
Plug 'github/copilot.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" System clipboard
set clipboard+=unnamedplus

" Enable vim features
set nocompatible

" Reset filetype detection
filetype off

" Enable it
filetype plugin indent on

" Automatically read changed file
set autoread

" Persistent Undo
set undodir="$HOME"/.vim/undodir
set undofile

" Don't wrap lines
set nowrap

" No swap files
set noswapfile

" Show line numbers
set number relativenumber
set nu rnu

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_disable_lsp = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1

let g:ale_fixers = {
\"python": [
  \"add_blank_lines_for_python_control_statements",
  \"black",
  \"isort",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"sh": [
  \"shfmt",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"c": [
  \"clang-format",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"cpp": [
  \"clang-format",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"go": [
  \"gofmt",
  \"goimports",
  \"trim_whitespace",
  \"remove_trailing_lines"
\],
\"rust": [
  \"rustfmt",
  \"trim_whitespace",
  \"remove_trailing_lines"
\],
\"javascript": [
  \"prettier",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"typescript": [
  \"prettier",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"html": [
  \"prettier",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"sql": [
  \"pgformatter",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"nix": [
  \"nixfmt",
  \"statix",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"json": [
  \"jq",
  \"remove_trailing_lines",
  \"trim_whitespace"
\],
\"zig": [
  \"zigfmt",
  \"trim_whitespace",
  \"remove_trailing_lines"
\],
\"fortran": [
  \"trim_whitespace",
  \"remove_trailing_lines"
\],
\"fsharp": [
  \"trim_whitespace",
  \"remove_trailing_lines"
\],
\"r": [
  \"trim_whitespace",
  \"remove_trailing_lines",
  \"styler"
\]
\}

let g:ale_linters = {
\"python": [
  \"flake8",
  \"bandit",
  \"pylint"
\],
\"sh": [
  \"shellcheck"
\],
\"c": [
  \"clangd",
  \"cppcheck"
\],
\"cpp": [
  \"clangd",
  \"cppcheck"
\],
\"go": [
  \"gotype",
  \"golint",
  \"gopls",
  \"gobuild",
  \"govet"
\],
\"rust": [
  \"analyzer"
\],
\"json": [
  \"jq"
\],
\"javascript": [
  \"eslint",
  \"prettier"
\],
\"typescript": [
  \"eslint",
  \"prettier"
\],
\"nix": [
  \"rnix_lsp",
  \"statix",
\],
\"zig": [
  \"zls",
\],
\"fortran": [
  \"gcc",
\],
\"r": [
  \"languageserver",
\]
\}

let g:ale_python_pylint_options = "--disable=C0111,C0112,C0301,C0302"
let g:ale_python_flake8_options = "--ignore=E501"
let g:ale_python_mypy_options = "--ignore-missing-imports"
let g:ale_sql_pgformatter_options = "--comma-break"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_auto_type_info = 0
let g:go_jump_to_error = 0
let g:go_fmt_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_doc_keywordprg_enabled = 0

" Extra Syntax Highlighting
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0

" Easier test file opening
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')


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

" Syntax highlighting
syntax on

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

" Vertical Split resizing
nmap <C-W>< <C-W><<SID>ws
nmap <C-W>> <C-W>><SID>ws
nn <script> <SID>ws< <C-W><<SID>ws
nn <script> <SID>ws> <C-W>><SID>ws

" Horizontal Split resizing
nmap <C-W>+ <C-W>+<SID>ws
nmap <C-W>- <C-W>-<SID>ws
nn <script> <SID>ws+ <C-W>+<SID>ws
nn <script> <SID>ws- <C-W>-<SID>ws

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
set signcolumn=auto

function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ CheckBackSpace() ? "\<Tab>" :
    \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)ndif

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" use `:Sort` for organize python imports isort
command! -nargs=0 Sort :call CocAction('runCommand', 'python.sortImports'

" auto close scratch/preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup yaml_files
    autocmd!
    au BufRead,BufNewFile *.yml setfiletype yaml
    au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup c_files
    autocmd!
    au FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup fortran_files
    autocmd!
    au FileType fortran setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup cpp_files
    autocmd!
    au FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup make_files
    autocmd!
    au FileType make setlocal noexpandtab
augroup END

augroup docker_files
    autocmd!
    au BufRead,BufNewFile Dockerfile.* set syntax=Dockerfile
augroup END

augroup go
    autocmd!
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8
augroup END

augroup markdown_files
    autocmd!
    autocmd FileType markdown set wrap
augroup END

augroup json_files
    autocmd!
    au FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup typescript_files
    autocmd!
    au FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup xml_files
    autocmd!
    au FileType xml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup html_files
    autocmd!
    au FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" another alias for ripgrep
nmap <LEADER>rg :Rg <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Vim-Slime
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-terraform
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:terraform_fmt_on_save = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copilot
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
