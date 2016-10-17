" vim: fdm=marker
"
" convenient vim commands
"
" :%s/\s\+$// -- remove trailing whitespace (to remove at beginning just <<)
" :perldo s/(\d+\.\d+)/sprintf "%.2f", $1/eg -- round all numbers to some
" number of digits
" :%s/ \+/ /g -- compress all whitespace to 1 space
" /^.\{81,\}$ -- search for all lines at least 81 characters long
"
"

set nocompatible
let g:netrw_dirhistmax=10

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
if $NO_PLUGIN !=? "TRUE"
    execute pathogen#infect()
endif

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" {{{ built in config options
set backspace=2 " allows deletion of newlines, automatic indentation
set modeline
filetype plugin indent on

"set line numbers
set nu
set rnu
"indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
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
" wrapping + highlight
set tw=0
hi ColorColumn ctermbg=red guibg=red
set cc=81
" show opening operator when closing
set showmatch
" define what words are in vim
set iskeyword=@,48-57,192-255,_
" define tags files
set tags=./.tags;

" statusline
set laststatus=2            " always statusbar
set statusline=%{getcwd()}: " pwd of vim
set statusline+=\ %f%m%=    " relative path to filename, modified flag, RHS
set statusline+=%c,         " char number
set statusline+=%l/%L\ %y   " curr line/total line [filetype]

" always show tabline (2) or only show when multiple (1)
set showtabline=1

" if persistent_undo, configure a directory for it
if has("persistent_undo")
    set undodir=$HOME/.undodir/
    set undofile
endif
" }}}
" {{{ keybindings
" paste mode toggle
set pastetoggle=<F12>
" <F8> but not actually a function key?
map [19~ <C-W>
" reload vimrc
nnoremap <C-W><C-R> :so $MYVIMRC<CR>

" line numbers
noremap <F3> :set number! relativenumber! <CR>

" buffer splitting
cnoreabbrev vb vert sball
cnoreabbrev sb sball

" makes repeating commands easier
nnoremap <space> @q

" insert mode, S-Tab = Tab
imap <S-Tab> <Tab>

" unmap stuff
map <F1> <Nop>
map Q <Nop>
imap <F1> <Nop>
vmap <F1> <Nop>
inoremap <C-U> <Nop>

" close any preview & help windows
nnoremap <Leader>h :pc<CR>:helpclose<CR>
" }}}
" {{{ autocmds
" always use last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
"Use templates
autocmd BufNewFile * silent! 0r ~/.vim/temps/temp.%:e
autocmd BufNewFile Makefile silent! 0r ~/.vim/temps/Makefile
" remove trailing whitespace on exit
autocmd BufWritePre * %s/\s\+$//e
" update ctags if found
autocmd BufWritePost * :call UpdateCtags()

" list of triggers (normal mode only)
" gcc - commentary comment out
" gs/ys/cs - vim-surround
" <C-P> - ctrlp
" <Leader>a - tabularize
" <Leader>b - bufexplorer
" <Leader>c[lv] - latex keybindings
" <Leader>c[npq] - quickfix keybindings
" <Leader>e - easymotion prefix [wb]
" <Leader>f[tsmi] - fold method keybindings
" <Leader>g - tagbar toggle
" <Leader>h - close preview/scratch
" <Leader>l[npq] - location list keybindings
" <Leader>t - nerdtree
" <Leader>u - undotree
" <Leader>R - YCM refactor
" <Leader><Leader>w - Easymotion move

nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>
nnoremap <Leader>ll :ll<CR>
nnoremap <Leader>lq :lclose<CR>

nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
nnoremap <Leader>cl :cc<CR>
nnoremap <Leader>cq :cclose<CR>
" }}}
