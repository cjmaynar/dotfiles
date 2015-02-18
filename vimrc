set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'bling/vim-airline'
Plugin 'jelera/vim-javascript-syntax'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
"Bundle 'scrooloose/syntastic'
Bundle 'tmhedberg/SimpylFold'
Bundle 'Townk/vim-autoclose'
Bundle 'valloric/MatchTagAlways'
Bundle 'wookiehangover/jshint.vim'

Bundle 'pydoc.vim'
Bundle 'RelOps'
Bundle 'The-NERD-tree'
Bundle 'taglist.vim'
Bundle 'TagHighlight'

" General {
    filetype plugin indent on
    syntax enable          "turn syntax highlighting on
    set autowrite          "automatically write file on exit
    set clipboard+=unnamed "Yanks go to clipboard
    colorscheme desert     "pick a decent colorscheme
    set background=light
    set visualbell         "no beeping"

    let mapleader = ","
    let g:mapleader = ","

    set hidden "Allow unsaved files to be hidden
    "Turn off backup since everything is tracked in version control
    set nobackup
    set nowb
    set noswapfile

    " Mark 81st color for highlight
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)
" }

" vim UI {
    set ttyfast      "Assume a fast connection
    set showmode     "Display the current mode
    set showcmd      "Display incomplete commands below status line
    set history=100  "Default was 20
    set ruler        "Show the cursor location
    set laststatus=2 "Always show status line
    " Made uncessary by airline plugin
    "set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%l,%v]
    "              | | | | |  |   |      |  |     |  |
    "              | | | | |  |   |      |  |     |  +- current col
    "              | | | | |  |   |      |  |     +- current line
    "              | | | | |  |   |      |  +- cur percent of file
    "              | | | | |  |   |      +- cur syntax
    "              | | | | |  |   +- cur fileformat
    "              | | | | |  +- num lines
    "              | | | | +- preview flag
    "              | | | +- help flag
    "              | | +- readonly flag
    "              | +- modified flag
    "              +- full path to file
    set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

    " Backspace over everything in insert mode
    set backspace=indent,eol,start
    " Invisible characters
    set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:❯,precedes:❮
    set linespace=0                "keep chars right next to eachother
    set nu                         "show line numbers
    set showmatch                  "show matching brackets/prarens
    set hlsearch                   "highlight searches
    set incsearch                  "highlight as you search
    set ignorecase                 "case insensitve search
    set smartcase                  "if searching with caps, require them
    set gdefault                   "set global replace as default
    set wildmenu                   "show list instead of just completing
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,*.cml
    set wildmode=list:longest,full "completion: list matches, longest common part, then all
    set scrolljump=5               "lines to scroll when cursor leaves screen
    set scrolloff=3                "minlines to keep above and below cursor
" }

" Formatting {
    set autoindent   "indent at same level as previous line
    set shiftwidth=4 "use indents of 4 spaces
    set tabstop=4
    set expandtab    "use spaces for tabs
    set smarttab     "work with the new tab settings

    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight merge conflicts
" }

" Remaps {
    set gdefault     "s/foo/bar -> s/foo/bar/g

    " Turn off Vim's regex handling
    nnoremap / /\v
    vnoremap / /\v

    " make getting out of insert easier
    imap jj <esc>
    " save a key press
    map ; :
    " make moving thorugh windows easier
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-h> <C-w>h
    map <C-l> <C-w>l
    "Treat long lines as break lines
    map j gj
    map k gk
    "Map space to search and ctr-space to back search
    map <space> /
    map <C-space> ?
    " EX mode doesn't do much for me, so map Q to run the macro
    " in the q register: qq = record, Q = run it
    map Q @q
    " Swich working directory to dir of open buffer
    map <leader>cd :cd %:p:h<cr>:pwd<cr>
    " Open/Close NERDTree
    map <leader>f <Esc>:NERDTreeToggle<CR>
    " Open/Close TagList
    map <leader>t <Esc>:TlistToggle<CR>
    " toggle set paste
    noremap <leader>p :set paste!<CR>
    " Shortcut for ack
    nnoremap <leader>a :Ack<Space>
    "Fold HTML tags
    nnoremap <leader>ft Vatzf

    " Make tab move between matching brackets
    nnoremap <tab> %
    vnoremap <tab> %

    " Use the arrow keys for changing window sizes
    nmap <left> :3wincmd <<CR>
    nmap <right> :3wincmd ><CR>
    nmap <up> :3wincmd +<CR>
    nmap <down> :3wincmd -<CR>
" }

" Clear last search highlighting with enter and clear the command line
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>:<backspace>
  endfunction
  call MapCR()

" Re-highlight last search pattern
nnoremap <leader>hs :set hlsearch<cr>

" Plugin Specific configuration {
    " CtrlP settings
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_match_window = 'bottom,order:ttb'
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|\.(o|swp|pyc|egg)$'

    " vim-airline settings
    " when only one tab is open, show all of the open buffers
    let g:airline#extensions#tabline#enabled = 1
    " user powerline patched fonts
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'murmur'
    " dict of configurably unicode symbols. mmmmmmmmmm
    let g:airline_symbols = {}
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.whitespace = 'Ξ'

    " Preview docstrings on folded Python methods
    let g:SimpylFold_docstring_preview = 1

    let JSHintUpdateWriteOnly=1

    let g:used_javascript_libs = 'jquery'

    " Close the tip window when an autocomplete selection is made,
    " or when leaving insert mode
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }
