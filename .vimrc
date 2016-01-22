" VIM: set rnu
" modelines
"
" convenient vim commands
"
" :%s/\s\+$// -- remove trailing whitespace (to remove at beginning just <<)
" :perldo s/(\d+\.\d+)/sprintf "%.2f", $1/eg -- round all numbers to some
" number of digits
" :%s/ \+/ /g -- compress all whitespace to 1 space
"
"



set tw=79
filetype plugin indent on
set foldmethod=syntax " alternatively, could use indent

" pathogen
execute pathogen#infect()





" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"                               built in config options
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

"set line numbers
set nu
set rnu
"indentation
set tabstop=4
set expandtab
set sw=4
set ls=2
set smarttab autoindent
"set highlight search
set hlsearch
" Set up hidden files
set hidden
" syntax highlighting
syntax on
" colors!!
colorscheme desert
" timeout len when waiting for input
set timeoutlen=500

" statusline
set statusline=%t%m%=
set statusline+=%c,
set statusline+=%l/%L

" recognize tex correctly
let g:tex_flavor = "latex"





" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"                                   keybindings
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" paste mode toggle
set pastetoggle=<F12>

" line numbers
map <F4> :set nonumber norelativenumber <CR>
map <F3> :set number relativenumber <CR>

" makes commentary easier
inoremap <F2> <ESC><F2>

" makes repeating commands easier
nnoremap <space> @q

" reload vimrc
nnoremap <F5> :so $MYVIMRC <CR>


" unmap stuff
map <F1> <Nop>
map <S-Tab> <Tab>
map Q <Nop>
imap <F1> <Nop>
vmap <F1> <Nop>
inoremap <C-U> <Nop>

" buffer management
set wildmenu
set wildcharm=<F10>
nnoremap <C-B> :b <F10>




" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"                                   autocmds
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" always use last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
"Use templates
autocmd BufNewFile * silent! 0r ~/.vim/temps/temp.%:e
autocmd BufNewFile Makefile silent! 0r ~/.vim/temps/Makefile
" wrap all txt files
autocmd bufreadpre,bufnewfile *.py set foldmethod=indent






" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"                                   ultisnips config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" Trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"
" :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" helpful
imap <S-tab> <tab>
