{ config, pkgs, lib, ... }:

let
  myConfiguredVim = with pkgs;
    (vim_configurable.override {
      guiSupport = "no";
      darwinSupport = true;
    }).customize {
      name = "vim";
      vimrcConfig = {
        customRC = ''
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " Main Settings
          """""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " System clipboard
          set clipboard^=unnamed,unnamedplus

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
                  \"clangtidy",
                  \"remove_trailing_lines",
                  \"trim_whitespace"
              \],
              \"cpp": [
                  \"clang-format",
                  \"clangtidy",
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
              \],
              \"cpp": [
                  \"clangd",
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

          " Use tab for trigger completion with characters ahead and navigate.
          " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
          " other plugin before putting this into your config.
          inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()

          inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

          function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
          endfunction

          " Use <c-space> to trigger completion.
          if has('nvim')
            inoremap <silent><expr> <c-space> coc#refresh()
          else
            inoremap <silent><expr> <c-@> coc#refresh()
          endif

          " Make <CR> auto-select the first completion item and notify coc.nvim to
          " format on enter, <cr> could be remapped by other vim plugin
          inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

          " ripgrep search results
          nmap <LEADER>fr :Rg <CR>

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
        '';

        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            ale
            coc-nvim
            coc-rls
            coc-pyright
            coc-tsserver
            coc-html
            coc-json
            vim-go
            fzf-vim
            tcomment_vim
            dracula-vim
            vim-airline
            vim-airline-themes
            vim-gitgutter
            vim-terraform
            vim-slime
            vim-fugitive
          ];
        };
      };
    };

in {
  home = {
    username = "jasonadam";
    homeDirectory = "/Users/jasonadam";

    packages = with pkgs; [
      htop
      kubectl
      exa
      ctags
      ripgrep
      jq
      tmux-mem-cpu-load
      gh
      google-cloud-sdk
      docker
      docker-compose
      spaceship-prompt
      rnix-lsp
      nixfmt
      statix
      terraform-ls
      fd
      tree
      nodejs
      powerline-symbols
      gopls
      gotests
      delve
      pgformatter
      shellcheck
      shfmt
      nodePackages.dockerfile-language-server-nodejs
      myConfiguredVim
      awscli2
    ];

    stateVersion = "22.05";
  };

  programs = {
    direnv = { enable = true; };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      shellAliases = {
        vimfzf = "vim $(fzf)";
        cat = "bat";
        ls = "exa --group-directories-first";
        la = "exa --group-directories-first --all";
        ll = "exa --group-directories-first --long";
        lst = "exa --group-directories-first --tree";
        llt = "exa --group-directories-first --long --tree";
      };

      oh-my-zsh = {
        enable = true;

        plugins =
          [ "git" "vi-mode" "docker" "docker-compose" "kubectl" "web-search" ];
      };

      localVariables = {
        ZSH_DISABLE_COMPFIX = true;
        COMPLETION_WAITING_DOTS = true;
      };
    };

    bat = {
      enable = true;

      config = { theme = "Dracula"; };
    };

    starship = {
      enable = true;

      settings = {
        add_newline = false;

        character = {
          success_symbol = "[::](bold green)";
          error_symbol = "[::](bold green)";
        };

        format = lib.concatStrings [
          "$directory"
          "$git_branch"
          "$git_status"
          "$character"
        ];

        package.disabled = true;
      };
    };

    fzf = {
      enable = true;

      defaultCommand = "fd --type file --hidden --no-ignore";
      defaultOptions = [ "--height 30%" "--border" ];

      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [ "--preview 'head {}'" ];

      changeDirWidgetCommand = "fd --type d";
      changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];

      historyWidgetOptions = [ "--sort" "--exact" ];
    };

    tmux = {
      enable = true;

      plugins = with pkgs.tmuxPlugins; [ yank ];

      keyMode = "vi";
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 5000;
      terminal = "xterm-256color";
      sensibleOnTop = false;

      extraConfig = ''
        # Pane Borders
        set -g pane-border-style bg=default,fg=colour238
        set -g pane-active-border-style bg=black,fg=colour141

        # Status Bar
        set -g status on
        set-option -g status-style fg=white,bg=black
        set-option -g status-interval 1
        set -g status-left-length 20
        set-option -g status-justify centre
        set-option -g status-left-style default
        set-option -g status-left "#[fg=white]#H #[fg=black]• #[fg=white,bright]#(uname -r)#[default]"
        set-option -g status-right-length 140
        set-option -g status-right-style default
        set -g status-right "#S #[fg=green,bg=black]#(tmux-mem-cpu-load --interval 2)#[default]"
        set-option -ag status-right " #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d"

        # Mouse support.
        set -g mouse on

        # split panes using | and -
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %

        # h, j, k, l
        bind -n C-h select-pane -L
        bind -n C-j select-pane -D
        bind -n C-k select-pane -U
        bind -n C-l select-pane -R

        # Resize panes
        bind -r C-H resize-pane -L 10
        bind -r C-J resize-pane -D 10
        bind -r C-K resize-pane -U 10
        bind -r C-L resize-pane -R 10
      '';
    };

    git = {
      enable = true;
      userName = "Jason Adam";
      userEmail = "22adamj22@gmail.com";

      signing = {
        key = "5F524B7FEA850D30";
        signByDefault = true;
      };

      aliases = {
        br =
          "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
        lg =
          "!git log --pretty=format:'%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]' --abbrev-commit -30";
        ctags = "!.git/hooks/ctags";
      };

      ignores = [
        "Session.vim"
        "Sessionx.vim"
        ".netrwhist"
        "*~"
        "*.swp"
        "tags"
        ".vim"
        ".idea/"
        ".DS_Store"
      ];

      extraConfig = {
        core = { editor = "vim"; };

        init = {
          defaultBranch = "main";
          templatedir = "/Users/jasonadam/.git_template";
        };

        web = { browser = "brave-browser"; };
      };
    };

    gpg.enable = true;

    home-manager.enable = true;
  };

}
