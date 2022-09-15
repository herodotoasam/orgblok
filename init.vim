packloadall
"commenting a line
"nnoremap s I#<Esc>j

set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" different version somewhere else.
Plugin 'ervandew/supertab'
Plugin 'morhetz/gruvbox'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'preservim/nerdtree'
Plugin 'mcchrish/nnn.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'dracula/vim'
Plugin 'folke/tokyoniht.nvim'
"Plugin 'edeneast/nightfox.nvim'
Plugin 'jacoborus/tender.vim'
"Plugin 'ycm-core/YouCompleteMe'
"Plugin 'neovim/nvim-lspconfig'
"Plugin 'nvim-lua/completion-nvim'
"""Plugin 'kristijanhusak/orgmode.nvim'
"Plugin 'dhruvasagar/vim-dotoo'
Plugin 'mbbill/undotree'
Plugin 'airblade/vim-rooter'
"Plugin  'mcchrish/nnn.vim'
"Plugin 'nvim-telescope/telescope.nvim'
"Plugin 'neoclide/coc.nvim', {'branch': 'release'}
call vundle#end()            " required
filetype plugin indent on    " required


" lua << EOF
" require'lspconfig'.pyright.setup{}
" EOF

"set guifont=DejaVu\ Sans\ Mono:h14
set guifont=Fira\ Code\ Mono:h15
"colorscheme gruvbox
colorscheme dracula
set background=dark
"colorscheme zenburn
" colorscheme desert
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
nnoremap <F6> :w<cr> :!wish %<CR>
nnoremap <C-z> :w<cr> :!bash %<CR>


:map <F12> :e /home/hero/.config/nvim/init.vim <cr>
:map <F8> :e /home/hero/orgblok/pro.org <cr>

":map <C-n>  :Files<cr>
:map <C-n> :NnnPicker<cr>
:map <C-b>  :Buffers<cr>
:map <C-t>  :BTags<cr>
:map <F3>   :NERDTreeToggle<CR>
" :map <F3>  :30vs +Ex<cr>
"mueve la linea abajo
let NERDTreeQuitOnOpen=1

:map <A-Up> :.,m.-2<CR>
"mueve la linea arriba
:map <A-Down> :.,m.+<CR>
"duplica la linea
":map <C-D> :.,co.<CR>

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
set nobackup
set nowritebackup
set noswapfile
set history=1000
set mouse=a

set nocompatible
set modelines=0

" set columns=173
" set lines=41

"folding
"set foldmethod=indent
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
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

"tweaks for netrw
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_listhide=netrw_gitignore#Hide()
let g:netrw_listhide=',\(^\|\s\s\)\zs\.\S\+'


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

" para jedi
let g:jedi#use_splits_not_buffers = "bottom"

" run python script con F9
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Completion by Conqueror
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
 inoremap <silent><expr> <TAB>
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

 " lua << EOF
 " local nvim_lsp = require('lspconfig')

 " -- Use an on_attach function to only map the following keys
 " -- after the language server attaches to the current buffer
 " local on_attach = function(client, bufnr)
 "   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
 "   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

 "   --Enable completion triggered by <c-x><c-o>
 "   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

 "   -- Mappings.
 "   local opts = { noremap=true, silent=true }

 "   -- See `:help vim.lsp.*` for documentation on any of the below functions
 "   buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
 "   buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
 "   buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
 "   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
 "   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
 "   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
 "   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
 "   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
 "   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
 "   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
 "   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
 "   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
 "   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
 "   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
 "   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
 "   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
 "   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

 " end

 " -- Use a loop to conveniently call 'setup' on multiple servers and
 " -- map buffer local keybindings when the language server attaches
 " local servers = { "pyright", "rust_analyzer", "tsserver" }
 " for _, lsp in ipairs(servers) do
 "   nvim_lsp[lsp].setup {
 "     on_attach = on_attach,
 "     flags = {
 "       debounce_text_changes = 150,
 "     }
 "   }
 " end
" EOF


