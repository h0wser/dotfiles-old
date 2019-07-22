" h0wser's extremely cool and awesome .vimrc file
" most of it is copied...
set nocompatible
filetype off
" -------------- vim-plug -----------"
call plug#begin('~/local/share/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'

call plug#end()

" ------------- MISC -----------"
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set laststatus=2
set ruler
set autoindent
set scrolloff=10
set nowrap
set linebreak
set relativenumber
set number

set incsearch
set hlsearch

set listchars=tab:<=,trail:*

" ------------------- DEOPLETE -----------
let g:deoplete#enable_at_startup = 1

let g:jedi#completions_enabled = 0

let g:jedi#documentation_command = "C-K"
let g:jedi#use_splits_not_buffers = "right"

" Tab complete
inoremap <expr><tab> pumvisible() ? "<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "<c-p>" : "\<s-tab>"

highlight! link MatchParens StatusLine

" Highlight over 80 chars
highlight OverLength ctermbg=cyan ctermfg=white guibg=#592929

" Haskell tab settings
autocmd FileType haskell match OverLength /\%81v.\+/
autocmd FileType haskell set expandtab

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ----------------- KEY MAPPINGS ---------------

inoremap <NL> <CR><CR><Esc>ki<Tab>

"	Escaping braces and stuff
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" Easier braces/brackets on nordic keyboard
inoremap ö {
inoremap ä }
inoremap Ö [
inoremap Ä ]

" Switching between header and source quickly
nnoremap ö :w<CR>:A<CR>
nnoremap Ö :AS<CR>
nnoremap å :noh<CR>

nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

nnoremap J 5j
nnoremap K 5k

inoremap <s-tab> <c-d>

tnoremap <Esc> <C-\><C-n>

let mapleader=" "

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>e :Ex<cr>

" Escape for different modes
inoremap jk <esc>

" this might need cleaning
set runtimepath+=~/.nvim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.nvim/after
