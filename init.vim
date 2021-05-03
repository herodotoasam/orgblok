packloadall
"commenting a line
nnoremap s I#<Esc>j

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" different version somewhere else.
Plugin 'morhetz/gruvbox'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'preservim/nerdtree'
Plugin 'jceb/vim-orgmode'

call vundle#end()            " required
filetype plugin indent on    " required


colorscheme gruvbox
nnoremap j gj
nnoremap k gk
inoremap jk <esc>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-up> :bp<cr>
nnoremap <C-down> :bn<cr>

nnoremap q :q<cr>
nnoremap wq :wq<cr>
nnoremap <C-s> :w<cr>
nnoremap <C-z> :w<cr> :!wish %<CR>

:map <F12> :e /home/hero/.config/nvim/init.vim <cr>

:map <C-n>  :Files<cr>
:map <C-b>  :Buffers<cr>
:map <C-t>  :BTags<cr>
:map <F3>   :NERDTreeToggle<CR>

"mueve la linea abajo
:map <A-Up> :.,m.-2<CR>
"mueve la linea arriba
:map <A-Down> :.,m.+<CR>
"duplica la linea
:map <C-D> :.,co.<CR>

:syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=79
set expandtab
set autoindent
set fileformat=unix

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set undofile

set nocompatible
set modelines=0

"folding
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

"requerido por air
set laststatus=2
let g:airline_section_z='%t'

"requerido para que Ack use ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"requerido por Ctrl-p
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"ver los espacios en blanco o tabs mal puestos
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Configuracion recomendada por django
" """"""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""
" para ultisnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
let g:user_emmet_leader_key = ','

inoremap <C-f> <C-R>=strftime('[%F %a]')<cr>
map <C-f> :put =strftime('[%F %a]')<cr>
