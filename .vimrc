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
" :g/pattern/d - delete lines matching this pattern (:g! for not-matching)
" :sort - sorts lines (':sort u' to keep only unique)
"
" gv - restore the last visual selection
" ga - information on the character under the cursor
" g[Uu~]{motion} - uppercase/lowercase/swap until motion
" //e goes to end of match
"

set nocompatible

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

" set line numbers
set nu
set rnu
" indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab autoindent
" cindent options
" set cino=(1s " after parens, indent only one shiftwidth
" set cino+=m1 " line up closing parens w/ first char of line of opening parens
" setup search
" set hlsearch " highlight search, superceded by autocmds and mappings
set incsearch " search as you go
" Set up hidden files
set hidden
" syntax highlighting
syntax on
" colors!!
colorscheme desert
" timeout len when waiting for input
set timeoutlen=500
" wrapping + highlight
set wrap
set tw=80
" hi ColorColumn ctermbg=Red
" set cc=81
" show opening operator when closing
set showmatch
" define what words are in vim
set iskeyword=@,48-57,192-255,_
" define tags files
set tags=./.tags;

" show mode in status bar (compatibility?)
set showmode
" show commands in bottom right
set showcmd
" show horizontal line for cursor
set cursorline
" command line tab-completion
set wildmenu
set wildmode=longest:full,full
" no need to set two spaces after punctuation...
set nojoinspaces
" neat whitespace highlighting
set list
hi SpecialKey ctermbg=DarkRed ctermfg=DarkGreen
set listchars=tab:>-,trail:\ ,nbsp:~
set showbreak=\\ " mark wrapped lines w/ backslash

" statusline
set laststatus=2            " always statusbar
set statusline=%{getcwd()}: " pwd of vim
set statusline+=\ %f%m%=    " relative path to filename, modified flag, RHS
set statusline+=%c,         " char number
set statusline+=%l/%L\ %y   " curr line/total line [filetype]
set statusline+=%{fugitive#statusline()}

" always show tabline (2) or only show when multiple (1)
set showtabline=1

" if persistent_undo, configure a directory for it
if has("persistent_undo")
    set undodir=$HOME/.undodir/
    set undofile
endif

autocmd BufRead,BufNewFile *.h set filetype=c " *.h files are c, not cpp (wrt stnippets)
autocmd BufRead,BufNewFile *.ts set filetype=javascript " *.h files are c, not cpp (wrt stnippets)
" }}}
" {{{ keybindings
" paste mode toggle
set pastetoggle=<F12>
" <F8> but not actually a function key?
map [19~ <C-W>
" reload vimrc
nnoremap <C-W><C-R> :so $MYVIMRC<CR>
nnoremap <C-W>q :bd <CR>

" line numbers
noremap <F3> :set number! relativenumber! <CR>

" buffer splitting
cnoremap vb vert sball

" makes repeating commands easier
nnoremap <space> @q

" insert mode, S-Tab = Tab
imap <S-Tab> <Tab>

" insert MM/DD/YY
inoremap <C-B> <C-R>=strftime('%D')<CR>

" unmap stuff
map <F1> <Nop>
map Q <Nop>
imap <F1> <Nop>
vmap <F1> <Nop>
inoremap <C-U> <Nop>

" close any preview & help windows
nnoremap <Leader>h :pc<CR>:helpclose<CR>
" resync comments since dumb
nnoremap <Leader>s :syntax sync fromstart<CR>
" cd to path of current file
cnoremap cd. lcd %:p:h
" let . work in visual mode too
vnoremap . :normal .<CR>
" let n, N, *, #, /, ? turn on hlsearch
nnoremap n :set hlsearch <CR>n
nnoremap N :set hlsearch <CR>N
nnoremap * :set hlsearch <CR>*
nnoremap # :set hlsearch <CR>#
nnoremap / :set hlsearch <CR>/
nnoremap ? :set hlsearch <CR>?
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

" automatically cd to directory of current file
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" automatically turn off highlight when in insert mode
autocmd InsertEnter * set nohlsearch
" }}}
" {{{ triggers
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>
nnoremap <Leader>ll :ll<CR>
nnoremap <Leader>lq :lclose<CR>

nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
nnoremap <Leader>cl :cc<CR>
nnoremap <Leader>cq :cclose<CR>

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
" }}}
" {{{ packadd's
if has('syntax') && has('eval') && v:version > 800
  packadd matchit
endif
" }}}
