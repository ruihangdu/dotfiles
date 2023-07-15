" BASIC VIMRC SKELETON "

" Automatic reloading of .vimrc on file change
autocmd! bufwritepost .vimrc source %

" Normal backspace
set bs=2

let mapleader=','

" ENTIRELY Personal Preference Mappings
" Easy normal mode
imap jk <Esc>
" Easy pane movement
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
" Easy scrolling
noremap <c-e> <c-e><c-e><c-e>M
noremap <c-w> <c-y><c-y><c-y>M
" Relative Line numbering
set rnu

" Better clipboard
set clipboard=unnamed

" Start using a color scheme
"mkdir ~/.vim; \
"git clone https://github.com/tomasiser/vim-code-dark && \
"mv vim-code-dark/* ~/.vim && rm -rf vim-code-dark

" Activating colorscheme and syntax
set term=xterm-256color
set t_Co=256
color codedark
syntax on
filetype plugin indent on
set number

" tabs vs. spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" god awful swap files
set nobackup
set nowritebackup
set noswapfile

" text object
" motions
" dot macro
" boss macro
" Buffers
" Tags

set tags=tags;/

" Set up package manager
" Vundle:
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" ------- Plugins -------

" File exploration
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

" Make vim prettier
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ntpeters/vim-better-whitespace'

" Code editting
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tomtom/tcomment_vim'

" Code Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" React snippets
Plugin 'epilande/vim-es2015-snippets'
Plugin 'epilande/vim-react-snippets'

call vundle#end()

"
" Plugin Config
"

" NERDTree
" call vundle#begin()
nnoremap <leader>n :NERDTreeToggle<cr>
" call vundle#end()

" ctrl-p
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*node_modules*

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" fugitive
set statusline+=%{fugitive#statusline()}

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" some customization
set hlsearch
" toggle highlight search
nnoremap <Space> :set hlsearch! hlsearch?<CR>
imap df <ESC>A
