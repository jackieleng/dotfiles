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
Plugin 'davidhalter/jedi-vim'  " need to do: 'pip install neovim' or compile with python extensions
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jackieleng/sexy_scroller.vim'  " fork of joeytwiddle's repo
"Plugin 'simnalamburt/vim-mundo'  " fork of Gundo with neovim support
"Plugin 'kshenoy/vim-signature'

" Tagbar needs ctags (sudo apt-get install exuberant-ctags)
Plugin 'majutsushi/tagbar'

Plugin 'haya14busa/incsearch.vim'
Plugin 'pangloss/vim-javascript'

" Color schemes
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




" --------------------
" Settings and options
" --------------------

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set autoread          " Automatically reload file when changed
set hidden            " Hide buffers instead of closing them
set t_Co=256          " 256 colors in terminal
set number            " line numbers
set nowrap            " don't wrap lines
set showcmd           " show commands
set showmatch         " set show matching parenthesis
set incsearch         " incremental search
set hlsearch          " highlight search
set ignorecase        " case insensitive search
set smartcase         " case insensitive search (except if word constains upper case)
set mouse=a           " enable mouse use in all modes
silent! set winwidth=85       " Automatic horizontal resizing
silent! set winminwidth=45    " The minimal width
" set winheight=50  " Automatic vertical resizing
let &showbreak='↪ '
set scrolloff=1       " lines visible below or above cursor
set shell=/bin/bash   " syntastic needs bash (and not e.g. fish)

if !has('nvim')
    " For tmux
    set term=screen-256color

    " Handle tmux $TERM quirks in vim. (ampersand means the option 'term')
    " if &term =~ '^screen-256color'
    "     map <Esc>OH <Home>
    "     map! <Esc>OH <Home>
    "     map <Esc>OF <End>
    "     map! <Esc>OF <End>
    " endif
endif

" Different colors between GUI and terminal
if has("gui_running")
    " For base16 colors in terminal
    let base16colorspace=256

    " Color scheme (do `:source ~/.vimrc` when switching)
    syntax enable
    colorscheme base16-ocean
    set background=dark
else
    " Solarized
    let g:solarized_termcolors=16
    syntax enable
    set background=light
    colorscheme solarized
    " This is needed for solarized because the sign column is hard to read with
    " gitgutter:
    " highlight clear SignColumn
    call togglebg#map("<F6>")
endif

" Search highlight color (hi = highlight)
" hi Search guibg=LightGreen

if has("gui_running")
    " Vim window startup size
    set lines=100 columns=207
    " Set the font
    set guifont=DejaVu\ Sans\ Mono\ 10

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
endif

set tabstop=8     " Linux kernel code default, also tabs are replaced by 8 spaces by Python
set softtabstop=4 " number of columns when hitting tab in insert mode
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

" autoread is not enough, you must still trigger reload with :e, :! or :checktime
augroup AutoFileReload
    au!
    au FocusGained,BufEnter * :silent! !
augroup END


" ------------
" Key mappings
" ------------

" Leader key
let mapleader = ","

" Press Space to turn off highlighting and clear any message already displayed
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

" FZF
nnoremap <silent> <Leader>fzf :FZF<CR>

" Toggle line numbers
nmap <F12> :set invnumber<CR>

" Easier tab movement
nnoremap <Leader>tc :tabnew<CR>
"nnoremap <Leader>tp :tabprev<CR>
"nnoremap <Leader>tn :tabnext<CR>

" Easier buffer switching
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>

" nnoremap <silent> <MouseDown> <MouseDown>:call s:CheckForChange(1)<CR>
" nnoremap <silent> <MouseUp> <MouseUp>:call s:CheckForChange(1)<CR>

" When switching buffers, preserve window view.
"if v:version >= 700
  "au BufLeave * if !&diff | let b:winview = winsaveview() | endif
  "au BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | unlet! b:winview | endif
"endif

let g:SexyScroller_AutocmdsEnabled = 0

if g:SexyScroller_AutocmdsEnabled == 0
    " Note: pretty crappy workaround because of double call, but it works...
    nnoremap <silent> <C-U> :call g:SexyScroller_ScrollToCursor(0)<CR><C-U>:call g:SexyScroller_ScrollToCursor(1)<CR>
    nnoremap <silent> <C-D> :call g:SexyScroller_ScrollToCursor(0)<CR><C-D>:call g:SexyScroller_ScrollToCursor(1)<CR>
    nnoremap <silent> <C-F> :call g:SexyScroller_ScrollToCursor(0)<CR><C-F>:call g:SexyScroller_ScrollToCursor(1)<CR>
    nnoremap <silent> <C-B> :call g:SexyScroller_ScrollToCursor(0)<CR><C-B>:call g:SexyScroller_ScrollToCursor(1)<CR>
    nnoremap <silent> <PageUp> :call g:SexyScroller_ScrollToCursor(0)<CR><PageUp>:call g:SexyScroller_ScrollToCursor(1)<CR>
    nnoremap <silent> <PageDown> :call g:SexyScroller_ScrollToCursor(0)<CR><PageDown>:call g:SexyScroller_ScrollToCursor(1)<CR>

    augroup Custom_Smooth_Scroller
      autocmd!
      autocmd WinEnter * call g:SexyScroller_ScrollToCursor(0)
      "autocmd BufWinEnter * call SexyScroller_ScrollToCursor(0)
      "autocmd BufWinEnter * call SexyScroller_ScrollToCursor(0) | echo "bufwinenter"
      "autocmd BufWinLeave * call SexyScroller_ScrollToCursor(0)
      "autocmd BufReadPost * call SexyScroller_ScrollToCursor(0)
      " autocmd BufEnter * call SexyScroller_ScrollToCursor(1)
      "autocmd BufWinLeave * call SexyScroller_ScrollToCursor(0)
      "autocmd BufWinEnter * call SexyScroller_ScrollToCursor(0)
      "autocmd InsertLeave * call SexyScroller_ScrollToCursor(0)
    augroup END
endif
" Sexy Scroller mouse workarounds
" let g:SexyScroller_MinLines = 15




" ---------------
" Plugin settings
" ---------------

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

" Do not use powerline fonts for airline
let g:airline_powerline_fonts = 0

" Disable syntastic integration
let g:airline#extensions#syntastic#enabled = 0

" Nicer airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline custom symbols when not using powerline fonts
" The unicode symbols will work if you do: sudo apt-get install ttf-ancient-fonts
" This installs a Symbola font
set encoding=utf-8
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline_symbols.linenr = ""
let g:airline_symbols.paste = "∥"
" let g:airline_symbols.branch = "⎇ "  " note the extra space
let g:airline_symbols.branch = ""  " note the extra space
let g:airline_symbols.space = " "
let g:airline_symbols.whitespace = "Ξ"
let g:airline_symbols.modified = '+'
let g:airline_symbols.readonly = "RO"

" Custom mode names in g:airline_section_a
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" Let's just disable it, mode names are shown always anyway.
let g:airline_section_a = ""

" Make linenr, column a bit tidier
let g:airline_section_z = '%3p%% ' . g:airline_symbols.linenr . ' %l,%c'

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

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
let g:incsearch#auto_nohlsearch = 0
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Jedi-vim
let g:jedi#show_call_signatures = 0  " disable function arg pop-up
let g:jedi#popup_on_dot = 0  " disable automatic completion on dot (use <C-Space>)
let g:jedi#smart_auto_mappings = 0  " disable auto-completion when typing `from module.name<space>`
