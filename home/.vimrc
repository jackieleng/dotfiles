set nocompatible              " be iMproved, required
filetype off                  " required

" FZF (external plugin)
set rtp+=~/.fzf

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'simnalamburt/vim-mundo'  " fork of Gundo with neovim support
"Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'   " Tagbar needs ctags (sudo apt-get install exuberant-ctags)
Plug 'pangloss/vim-javascript'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }

" Color scheme
Plug 'altercation/vim-colors-solarized'

" Initialize plugin system
call plug#end()


" --------------------
" Settings and options
" --------------------

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
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

" Only search git files
nnoremap <silent> <Leader>g :GFiles<CR>

" Toggle line numbers
nmap <F12> :set invnumber<CR>

" List buffers
nnoremap <silent> <Leader>b :Buffers<CR>

" ---------------
" Plugin settings
" ---------------

" Let airline/statusline appear all the time
set laststatus=2

" Don't load all extensions, only those we want 
let g:airline_extensions = ['branch', 'tabline']

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Exclude airline from preview window (causes bugs with YCM)
let g:airline_exclude_preview = 1
nnoremap <silent> <Leader>d :YcmCompleter GoTo<CR>

" Nicer airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline custom symbols when not using powerline fonts
" The unicode symbols will work if you do: sudo apt-get install ttf-ancient-fonts
" This installs a Symbola font
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.paste = "∥"
let g:airline_symbols.branch = "⎇"
let g:airline_symbols.space = " "
let g:airline_symbols.whitespace = "Ξ"
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.modified = '+'
let g:airline_symbols.readonly = "RO"

" Let's just disable it, mode names are shown always anyway.
let g:airline_section_a = ""

" Make linenr, column a bit tidier
let g:airline_section_z = '%3p%% ' . g:airline_symbols.linenr . ' %l,%c'

" Increase git gutter update rate
set updatetime=100
" Fix signs not updating after focussing in tmux.
let g:gitgutter_terminal_reports_focus=0
" Restore gitgutter old behavior that fixes unreadable sign column
highlight! link SignColumn LineNr

" If you don't want help windows to be restored:
set sessionoptions-=help
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options

" Tagbar
nmap <F8> :TagbarToggle<CR>

" YCM
let g:ycm_autoclose_preview_window_after_insertion = 1

" Vimwiki
" Use Markdown wiki markup
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

" Specify an interpreter that has the Neovim Python package (pynvim)
" https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
