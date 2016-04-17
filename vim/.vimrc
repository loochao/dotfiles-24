" Tab Options
set shiftwidth=4
set tabstop=4
" set expandtab "Enter spaces instead of tabs.

" {{{ Plugins
let s:configdir = '.vim'
if has('nvim')
  let s:configdir = '.config/nvim'
endif

if empty(glob('~/' . s:configdir . '/autoload/plug.vim'))
  silent call system('mkdir -p ~/' . s:configdir . '/{autoload,bundle,cache,undo,backups,swaps}')
  silent call system('curl -fLo ~/' . s:configdir . '/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  ~/' . s:configdir . '/autoload/plug.vim'
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/' . s:configdir . '/Plug')
    Plug 'tpope/vim-sensible'                   " sensible defaults.
    Plug 'tpope/vim-fugitive'                   " Complement git in vim - todo: learn this.
    Plug 'tpope/vim-sleuth'                     " Auto spacing/indenting conformity to files

    Plug 'vim-airline/vim-airline'              " Status line
    Plug 'jeffkreeftmeijer/vim-numbertoggle'    " Auto relative number toggling
    Plug 'airblade/vim-gitgutter'               " Live git changes visible
    Plug 'terryma/vim-multiple-cursors'         " Muliple cursors, akin to sublime text
    Plug 'jiangmiao/auto-pairs'                 " auto-pairs(brackets/quotes)

    Plug 'Valloric/YouCompleteMe',              { 'do': './install.py --clang-completer --system-libclang --omnisharp-completer', 'for': ['cpp', 'c', 'java', 'cs', 'python']}   " Autocompletion engine.
    Plug 'rdnetto/YCM-Generator', 'stable'      " Generate ycm files - :YcmGenerateConfig

    Plug 'mattn/emmet-vim',                     {'for': ['html', 'xml', 'xsl', 'xslt', 'xsd', 'css', 'sass', 'scss', 'less', 'mustache', 'php']}  " A tool for generating repetitive html/css. todo: learn this.
    Plug 'Valloric/MatchTagAlways',             {'for': ['html', 'xhtml', 'xml', 'jinja']} " Autocompletes tags.

    Plug 'junegunn/fzf',                        {'dir': '~/fzf', 'do': 'yes\| ./install'} " based fuzzy search.
    Plug 'junegunn/goyo.vim'                    " Distraction-free writing in vim.
    Plug 'junegunn/limelight.vim'               " A nice focus color plugin. using with goyo.

    " colors n shit
    Plug 'chriskempson/base16-vim'
    Plug 'jnurmine/zenburn'
    Plug 'nanotech/jellybeans.vim'
    Plug 'jdkanani/vim-material-theme'
    Plug 'lucy/term.vim'

call plug#end()
" }}}

" {{{ Plugin settings
" youcompleteme
let g:ycm_autoclose_preview_window_after_completion = 1
" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_section=''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '│'

" vim-multiple-cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
" }}}

" {{{ keybinds
" Define ' ' as map leader
let mapleader = ' '
let g:mapleader = ' '
" indenting keybinds
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Repurpose up and down arrow keys to move between the buffers
nnoremap <silent> <Down>   :bn<CR>
nnoremap <silent> <Up>  :bp<CR>
" copy visual
map <C-c> "+y<CR>
" toggle paste mode
set pastetoggle=<F2>
" NerdTree
" silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"
" }}}

" {{{ Misc

" set title and allow hidden buffers
set title
set hidden
set list

" Auto remove all trailing whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e

" Autosave files when focus is lost
:au FocusLost * :wa

" Line Numbers
set number
set numberwidth=3

" Path will be base dir that vim is opened from
set path=$PWD/**

set nomodeline
set noshowmode                                          " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set shortmess=atToOI                                    " To avoid the 'Hit Enter' prompts caused by the file messages
set undolevels=1000
set updatetime=1500
" Disable all bells
" set noerrorbells visualbell t_vb=

" Wild menu (Autocompletion)"
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.jpeg,*.png,*.xpm,*.gif
set wildmode=list:longest,full

" Backup and Swap
set nobackup
set nowritebackup
set noswapfile

" Search Options
set hlsearch   " Highlight search
set magic      " Set magic on, for regular expressions
set ignorecase " Searches are Non Case-sensitive
set smartcase

" FOLDING
set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=0

" Colors
set t_Co=256
let base16colorspace=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if empty(glob('~/.bspwm_theme'))
    colorscheme default
else
    let vim_colors=system("cat ~/.bspwm_theme | grep VIM_COLORS | cut -c 12-")
    execute 'colorscheme ' vim_colors
endif

set encoding=utf-8

" General UI Options
set mouse=a
set showmatch          " Shows matching brackets when text indicator is over them
set cursorline
set scrolljump=10
set ttyfast            " Improves redrawing for newer computers
set pumheight=20       " popup menu height
set diffopt+=context:3
set nostartofline      " when moving thru the lines, the cursor will try to stay in the previous columns

" LAYOUT / TEXT FORMATTING
" Formatting Options
set wrap " Soft Wrap in all files, while hard wrap can be allow by filetype
set linebreak " It maintains the whole words when wrapping
set smartindent

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" gvim options - remove the toolbar.
set guioptions-=L
set guioptions-=T
" }}}
