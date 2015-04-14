" h0wser's extremely cool and awesome .vimrc file
" most of it is copied...
" -------------- VUNDLE -----------"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'marijnh/tern_for_vim'
Plugin 'vim-scripts/Align'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/a.vim'
Plugin 'bling/vim-airline'

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
set number
set scrolloff=10
set cursorline
set nowrap
set linebreak
set relativenumber

set incsearch
set hlsearch

highlight! link MatchParens StatusLine

" ---------------- COLOR SETTINGS -----------"
set t_Co=256
colorscheme native 
set t_ut=

" ------------------AIR LINE----------------"
function! AirlineInit()
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_powerline_fonts = 1
endfunction
autocmd VimEnter * call AirlineInit()

" ----------------- KEY MAPPINGS ---------------
"	matching braces/parens etc...

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
nnoremap Ö :split %<CR><C-w><C-w>:A<CR>
nnoremap å :noh<CR>

nnoremap - ddp
nnoremap _ ddkp

inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwU


" Rust syntax m8
au BufRead,BufNewFile *.rs,*.rc set filetype=rust

" --------------GUI----------------------------------
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" -------------- YOUCOMPLETEME SETTINGS -------------
" YouCompleteMe need python 2, not 3
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set runtimepath+=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
