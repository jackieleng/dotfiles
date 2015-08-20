set nocompatible              " be iMproved, required
filetype off                  " required

" FZF (external plugin)
set rtp+=~/.fzf

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My plugins
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'hdima/python-syntax'
Plugin 'airblade/vim-gitgutter'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'    " Needed by vim-session
Plugin 'kien/ctrlp.vim'
Plugin 'moll/vim-bbye'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/goyo.vim'
" Plugin 'davidhalter/jedi-vim'  # makes things a bit slow and buggy
Plugin 'christoomey/vim-tmux-navigator'

"Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line





" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set autoread      " Automatically reload file when changed
set hidden        " Hide buffers instead of closing them
set t_Co=256      " 256 colors in terminal
set number        " line numbers
set nowrap        " don't wrap lines
set showcmd       " show commands
set showmatch     " set show matching parenthesis
set hlsearch      " highlight search
set ignorecase    " case insensitive search
set smartcase     " case insensitive search (except if word constains upper case)
set mouse=a       " enable mouse use in all modes

if !has('nvim')
    " For tmux
    set term=screen-256color

    " Handle tmux $TERM quirks in vim. (ampersand means the option 'term')
    if &term =~ '^screen-256color'
        map <Esc>OH <Home>
        map! <Esc>OH <Home>
        map <Esc>OF <End>
        map! <Esc>OF <End>
    endif
endif

" For base16 colors in terminal
let base16colorspace=256

" Color scheme (do `:source ~/.vimrc` when switching)
syntax enable
colorscheme base16-default
set background=dark

" This is needed for solarized because the sign column is hard to read with
" gitgutter:
" highlight clear SignColumn

" Search highlight color (hi = highlight)
" hi Search guibg=LightGreen

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Map horizontal scrolling to CTRL-L/H (note that CTRL-L is graphic reload on default)
" map <C-L> 3zl
" map <C-H> 3zh
" Map vertical scroll
" map <C-K> <C-Y>
" map <C-J> <C-E>

" Easier window switching
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resizing with leader key
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Easier tab movement
nnoremap tc :tabnew<CR>
nnoremap tp :tabprev<CR>
nnoremap tn :tabnext<CR>

if has("gui_running")
    " Vim window startup size
    set lines=100 columns=207
endif

set tabstop=4     " a tab is four spaces
set expandtab     " expand tab to spaces
set shiftwidth=4  " number of spaces to use for autoindenting

set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

" Highlight whitespaces/tabs etc.
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Always show line numbers, but only in current window.
" augroup line_numbers
"     au!
"     set number
"     au WinEnter * :setlocal number
"     au WinLeave * :setlocal nonumber
" augroup END


" ------------------Plugin specific settings------------------


" Let airline/statusline appear all the time
set laststatus=2

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" enable/disable detection of whitespace errors
let g:airline#extensions#whitespace#enabled = 0

" Disable gitgutter hunks in airline
let g:airline#extensions#hunks#enabled = 0

" Use powerline fonts for airline
let g:airline_powerline_fonts = 1

" Disable syntastic integration
let g:airline#extensions#syntastic#enabled = 0

" Set the font
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10

" Nicer airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" set encoding=utf-8
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" Start NERDTree on startup (with cursor in main window) TODO for linux
" autocmd VimEnter * NERDTree | wincmd p

" Toggle NERDTree with Ctrl-N
nmap <silent> <c-n> :NERDTreeToggle<CR>

" NERDTree ignores:
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.o$', '\.lo$', '\.mod$']

" Show hidden files
let NERDTreeShowHidden = 1

" Increase git gutter update rate
set updatetime=750

" Autosave and load sessions at close/start
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'

" If you don't want help windows to be restored:
set sessionoptions-=help
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options

" Let Syntastic check on file open
let g:syntastic_check_on_open = 1

" Custom vim-tmux-navigator settings
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> {c-\} :TmuxNavigatePrevious<cr>  " don't need

" ------------------------------------------------------------
