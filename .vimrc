:cd /home/hero/tcl1
set lines=50 columns=130
set path+=**
set cm=blowfish2 
set relativenumber

call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jreybert/vimagit'
Plug 'zuckonit/vim-airline-tomato'
Plug 'hsitz/VimOrganizer'
Plug 'mattn/calendar-vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-scripts/Tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug '~/.fzf' 
Plug 'tpope/vim-speeddating'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
call plug#end()


"ver los espacios en blanco o tabs mal puestos
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


syntax on
filetype plugin indent on
if has('gui_running')
        set background=light
        colorscheme gruvbox
    else
            set background=dark
            colorscheme solarized
        endif

"tweaks for netrw
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_listhide=netrw_gitignore#Hide()
let g:netrw_listhide=',\(^\|\s\s\)\zs\.\S\+'


"requerido por VimOrganizer
    au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()
:let g:agenda_dirs=["/home/hero/orgblok/"]
:let g:agenda_files = ['/home/hero/orgblock/vim.org','/home/hero/orgblock/edu-vim.org']

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

"requerido por tomato-pomodoro                                                                                                     
let g:tomato#show_clock = 1
let g:tomato#show_clock = 1
let g:tomato#show_count_down = 1 
let g:tomato#restinfo = "☺"
let g:tomato#remind = "☻"

"requerido por jedi
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 2
let g:jedi#completions_enabled = 0

let g:airline_theme='gruvbox'

set nocompatible
set modelines=0


set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

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

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1

nnoremap j gj
nnoremap k gk

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"nnoremap <C-up> :bp<cr>
"nnoremap <C-down> :bn<cr>
"nnoremap <C-right> :tabNext<cr>
"nnoremap <C-left> :tabprevious<cr>

nnoremap q :q<cr>
nnoremap wq :wq<cr>
nnoremap <C-s> :w<cr>

"quoting a word
nnoremap e ciw'<C-r>"'<Esc> 
nnoremap E ciw"<C-r>""<Esc> 
"commenting a line
nnoremap s I#<Esc>j

"cargardatoscliente del viejo .vimrc
set nobackup
set noswapfile
set guifont=Liberation\ Mono\ 12
"set guifont=FantasqueSansMono\ 14 
set guioptions-=r
set guioptions-=T
set guioptions-=m

"inoremap <expr> <C-f> strftime("%d-%m-%y",localtime())
inoremap <C-f> <C-R>=strftime('[%F %a]')<cr>
map <C-f> :put =strftime('[%F %a]')<cr>

:map ;0  :call tomato#reset()
:map ;v  :e /home/hero/.vimrc<cr>
:map ;6  :e /home/hero/tcl1/recibos.tcl<cr>
:map ;7  :e /home/hero/tcl1/ventas.tcl<cr>
:map ;9  :Explore /home/hero/orgblok/<cr>
:map [   :bp<cr>
:map ]   :bn<cr>
:map <C-s> :w<cr>

:map <F4>  :TagbarToggle<cr>
:map <F3>  :NERDTreeToggle<cr>

"mueve la linea abajo
:map <A-Up> :.,m.-2<CR>
"mueve la linea arriba
:map <A-Down> :.,m.+<CR>
"duplica la linea
:map <C-D> :.,co.<CR>
nnoremap <S-Right> g,
nnoremap <S-Left> g;


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""" RUN CURRENT FILE """""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Execute current file
"nnoremap <C-z> :w<cr> :call ExecuteFile()<CR>
nnoremap <C-z> :w<cr> :!wish %<CR>

" Will attempt to execute the current file based on the `&filetype`
" You need to manually map the filetypes you use most commonly to the
" correct shell command.
function! ExecuteFile()
  let filetype_to_command = {
  \   'javascript': 'node',
  \   'coffee': 'coffee',
  \   'python': 'python',
  \   'html': 'open',
  \   'sh': 'sh' ,
  \   'tcl': 'wish'
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  call RunShellCommand(cmd." %s")
endfunction

command! -complete=shellcmd -nargs=+ Shell call RunShellCommand(<q-args>)

function! RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

nnoremap \ :noh<return>

