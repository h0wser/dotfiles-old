" h0wser's extremely cool and awesome .vimrc file
" most of it is copied...
" -------------- VUNDLE -----------"
set nocompatible
filetype off

set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'marijnh/tern_for_vim'
Plugin 'vim-scripts/Align'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/a.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'unblevable/quick-scope'

call vundle#end()
filetype plugin indent on

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


highlight! link MatchParens StatusLine

" ---------------- COLOR SETTINGS -----------"
set background=dark
set t_Co=256
colorscheme 0x7A69_dark
set t_ut=

" Highlight over 80 chars
highlight OverLength ctermbg=cyan ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Haskell tab settings
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

nnoremap - ddp
nnoremap _ ddkp

inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwU

nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

" Escape for different modes
inoremap jk <esc>

" Rust syntax m8
au BufRead,BufNewFile *.rs,*.rc set filetype=rust

" -------------- YOUCOMPLETEME SETTINGS -------------
" YouCompleteMe need python 2, not 3
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set runtimepath+=~/.nvim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.nvim/after
