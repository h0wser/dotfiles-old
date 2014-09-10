" h0wser's extremely cool and awesome .vimrc file
" most of it is copied...

" ------------- MISC -----------"
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set laststatus=2
set ruler
set number
set autoindent
set scrolloff=10
set cursorline
set wrap
set linebreak
set autochdir

highlight! link MatchParens StatusLine

" ---------------- COLOR SETTINGS -----------"
set t_Co=256
colorscheme distinguished

" ----------------- KEY MAPPINGS ---------------
"	matching braces/parens etc...
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i

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

" Rust syntax m8
au BufRead,BufNewFile *.rs,*.rc set filetype=rust

" -------------- YOUCOMPLETEME SETTINGS -------------
" YouCompleteMe need python 2, not 3
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_signs = 0
