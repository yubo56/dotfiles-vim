" convenient vim commands
"
" :%s/\s\+$// -- remove trailing whitespace (to remove at beginning just <<)
"
"
filetype plugin indent on
set foldmethod=syntax

" vimlatex stuff
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf = 'zathura --debug error'
set grepprg=grep\ -nH\ $*

"set line numbers
set nu
set rnu
" only tex dosen't rnu b/c causes lag
autocmd BufRead,BufNewFile *.tex set nornu

"indentation options; 2 spaces per indent, autoindent
set tabstop=4
" set softtabstop=4
set expandtab
set sw=4
set ls=2
set smarttab autoindent

"set highlight search
set hlsearch

"syntax highlighting
syntax on

"colors!!
colorscheme desert

"Use templates
autocmd BufNewFile * silent! 0r ~/.vim/temps/temp.%:e
autocmd bufnewfile Makefile silent! 0r ~/.vim/temps/Makefile

" wrap all txt files
autocmd bufreadpre,bufnewfile *.txt setlocal tw=79 | setlocal fo+=t

"Set up hidden files
set hidden

" paste toggle
set pastetoggle=<F12>

" pathogen
execute pathogen#infect()

map <F4> :set nonumber norelativenumber <CR>
map <F3> :set number relativenumber <CR>
imap <F2> <ESC><F2>
map <C-F5> :make <CR>
" unmap stuff
map <F1> <Nop>
map Q <NOP>
imap <F1> <Nop>
vmap <F1> <Nop>
inoremap <C-U> <Nop>

" set mouse on (disables mouse selection copy)
" if has('mouse')
"   set mouse=a
" endif

" always use last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" line wrapping
" set wrap
" set tw=79

set statusline=%t%m%=
set statusline+=%c, 
set statusline+=%l/%L 
