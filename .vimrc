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
"

highlight! link MatchParens StatusLine

" ---------------- COLOR SETTINGS -----------"
set t_Co=256
colorscheme molokai
set t_ut=

" ----------------- KEY MAPPINGS ---------------
"	matching braces/parens etc...
" not using this atm cuz it's annoyying
"inoremap { {}<Esc>i
"inoremap ( ()<Esc>i
"inoremap [ []<Esc>i

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

" Rust syntax m8
au BufRead,BufNewFile *.rs,*.rc set filetype=rust

" -------------- YOUCOMPLETEME SETTINGS -------------
" YouCompleteMe need python 2, not 3
"let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_server_keep_logfiles = 1

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set runtimepath+=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
