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
Plugin 'VundleVim/Vundle.vim'

" My plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'hdima/python-syntax'
Plugin 'airblade/vim-gitgutter'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'    " Needed by vim-session
Plugin 'ctrlpvim/ctrlp.vim'  " Fork of kien's unmaintained version
Plugin 'moll/vim-bbye'
Plugin 'tpope/vim-fugitive'
" Plugin 'davidhalter/jedi-vim'  " To make this work with neovim you need to install the neovim python package (i.e.: pip install neovim) or compile neovim with python extensions
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'jackieleng/sexy_scroller.vim'  " fork of joeytwiddle's repo
"Plugin 'simnalamburt/vim-mundo'  " fork of Gundo with neovim support
"Plugin 'kshenoy/vim-signature'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'   " Tagbar needs ctags (sudo apt-get install exuberant-ctags)
" Plugin 'haya14busa/incsearch.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'vimwiki/vimwiki'
Plugin 'w0rp/ale'
Plugin 'junegunn/fzf.vim'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
"Plugin 'chriskempson/base16-vim'
"Plugin 'tomasr/molokai'

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
set scrolloff=1            " lines visible below or above cursor
set shell=/bin/bash        " syntastic needs bash (and not e.g. fish)
set wildmode=longest:list  " tab completion similar to Bash (as far as possible without ambiguity)
let g:netrw_liststyle=3    " nicer Netrw style
set encoding=utf-8

" Neovim options
if has('nvim')
    set inccommand=split       " live preview for substitute (Neovim option)
    " https://github.com/neovim/neovim/issues/5990
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
    set guicursor=
endif

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

" Solarized
let g:solarized_termcolors=16
syntax enable
set background=light
colorscheme solarized
call togglebg#map("<F5>")

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

set tabstop=4     " spaces per tab
set softtabstop=4 " number of columns when hitting tab in insert mode
set expandtab     " expand tab to spaces
set shiftwidth=4  " number of spaces to use for autoindenting

au FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
au FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

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

" Easier window switching
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Leader key
let mapleader = " "

" Turn off highlighting
nnoremap <silent> <Leader>n :noh<CR>

" Resizing with leader key
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" FZF
nnoremap <silent> <Leader>f :FZF<CR>

" Toggle line numbers
nmap <F12> :set invnumber<CR>

" Easier buffer switching
" nnoremap <Leader>l :buffers<CR>:buffer<Space>
nnoremap gB :bprevious<CR>
nnoremap gb :bnext<CR>

" Buffer list
nnoremap <silent> <Leader>l :CtrlPBuffer<CR>

" ---------------
" Plugin settings
" ---------------

" Let airline/statusline appear all the time
set laststatus=2

" Don't load all extensions, only those we want 
let g:airline_extensions = ['branch', 'tabline', 'ctrlp']

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Exclude airline from preview window (causes bugs with YCM)
let g:airline_exclude_preview = 1

" Nicer airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline custom symbols when not using powerline fonts
" The unicode symbols will work if you do: sudo apt-get install ttf-ancient-fonts
" This installs a Symbola font
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline_symbols.linenr = ""
let g:airline_symbols.paste = "∥"
let g:airline_symbols.branch = "⎇ "  " note the extra space
" let g:airline_symbols.branch = ""  " note the extra space
let g:airline_symbols.space = " "
let g:airline_symbols.whitespace = "Ξ"
let g:airline_symbols.modified = '+'
let g:airline_symbols.readonly = "RO"

" Let's just disable it, mode names are shown always anyway.
let g:airline_section_a = ""

" Make linenr, column a bit tidier
let g:airline_section_z = '%3p%% ' . g:airline_symbols.linenr . ' %l,%c'

" Increase git gutter update rate
set updatetime=750

" Autosave and load sessions at close/start
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'

" If you don't want help windows to be restored:
set sessionoptions-=help
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options

" Custom vim-tmux-navigator settings
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> {c-\} :TmuxNavigatePrevious<cr>  " don't need

" Incsearch
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
" " :h g:incsearch#auto_nohlsearch
" let g:incsearch#auto_nohlsearch = 0
" map n  <Plug>(incsearch-nohl-n)
" map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Jedi-vim
" let g:jedi#show_call_signatures = 0  " disable function arg pop-up
" let g:jedi#popup_on_dot = 0  " disable automatic completion on dot (use <C-Space>)
" let g:jedi#smart_auto_mappings = 0  " disable auto-completion when typing `from module.name<space>`

" YCM
let g:ycm_autoclose_preview_window_after_insertion = 1

" Speed up CtrlP
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Vimwiki
" Use Markdown wiki markup
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

" python-syntax
let python_highlight_all=1
