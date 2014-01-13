set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'SuperTab-continued.'
Bundle 'The-NERD-tree'
Bundle 'taglist.vim'
Bundle 'TagHighlight'
Bundle 'ack.vim'
Bundle 'Syntastic'
Bundle 'jslint.vim'
Bundle 'pydoc.vim'
Bundle 'RelOps'

" General {
    filetype plugin indent on
    syntax enable          "turn syntax highlighting on
    set autowrite      "automatically write file on exit
    set clipboard+=unnamed "Yanks go to clipboard
    colorscheme desert "pick a decent colorscheme

    " Re-source .vimrc whenever the file changes
    autocmd BufWritePost ~/.vimrc source %
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
    set ttyfast "Assume a fast connection
    set showmode "Display the current mode
    set showcmd "Display incomplete commands below status line
    set history=100 "Default was 20
    set ruler "Show the cursor location
    set laststatus=2 "always show status line
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

    " Backspace over everything in insert mode
    set backspace=indent,eol,start
    " Invisible characters
    set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:❯,precedes:❮

    set linespace=0
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
    set smarttab
" }

" Remaps {
    " Turn off Vim's regex handling
    nnoremap / /\v
    vnoremap / /\v

    imap jj <esc>
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

    "EX mode doesn't do much for me, so map Q to run the macro
    "in the q register: qq = record, Q = run it
    map Q @q

    "Swich working directory to dir of open buffe"
    map <leader>cd :cd %:p:h<cr>:pwd<cr>

    nnoremap <leader<space> :noh<cr>

    " Make tab move between matching brackets
    nnoremap <tab> %
    vnoremap <tab> %

    map <leader>f <Esc>:NERDTreeToggle<CR>
    map <leader>t <Esc>:TlistToggle<CR>

    "Fold HTML tags
    nnoremap <leader>ft Vatzf
" }
"

" Clear last search highlighting with enter and clear the command line
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>:<backspace>
  endfunction
  call MapCR()

" Re-highlight last search pattern
nnoremap <leader>hs :set hlsearch<cr>
