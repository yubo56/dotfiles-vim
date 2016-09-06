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

set nocompatible

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" built in config options
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

set backspace=2 " allows deletion of newlines, automatic indentation
filetype plugin indent on
set foldmethod=indent " alternatively, could use indent

"set line numbers
set nu
set rnu
"indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

" if persistent_undo, configure a directory for it
if has("persistent_undo")
    set undodir='~/.undodir/'
    set undofile
endif

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" keybindings
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" paste mode toggle
set pastetoggle=<F12>

" line numbers
map <F4> :set nonumber norelativenumber <CR>
map <F3> :set number relativenumber <CR>

" buffer splitting
cnoreabbrev vb vert sball
cnoreabbrev sb sball

" makes repeating commands easier
nnoremap <space> @q

" reload vimrc
" nnoremap <F5> :so $MYVIMRC <CR>

" insert mode, S-Tab = Tab
" normal mode, tab = lnext, S-tab = lprev
imap <S-Tab> <Tab>
nmap <Tab> :lnext<CR>
nmap <S-Tab> :ll<CR>

" unmap stuff
map <F1> <Nop>
map Q <Nop>
imap <F1> <Nop>
vmap <F1> <Nop>
inoremap <C-U> <Nop>

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" autocmds
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" always use last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
"Use templates
autocmd BufNewFile * silent! 0r ~/.vim/temps/temp.%:e
" wrap all txt files
autocmd BufNewFile Makefile silent! 0r ~/.vim/temps/Makefile
" remove trailing whitespace on exit
autocmd BufWritePre * %s/\s\+$//e

augroup js
    autocmd FileType javascript set tabstop=2
    autocmd FileType javascript set softtabstop=2
    autocmd FileType javascript set shiftwidth=2
augroup END

" list of plugin triggers (normal mode only)
" gcc - commentary comment out
" gs/ys/cs - vim-surround
" <C-P> - ctrlp
" <Leader><Leader>w - Easymotion move
" <Leader>[vsb] - bufexplorer
" <Leader>u - undotree
" <Leader>t - nerdtree
" <Leader>g - YCM refactor
" <Leader>R - YCM refactor



" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" ultisnips
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" Trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"
" :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" syntastic
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" recognize tex correctly
let g:tex_flavor = "latex"

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = { "regex": 'terminated with space\|' +
            \ 'between a pair of\|better written in dot' }

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" YouCompleteMe config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

let g:ycm_key_list_select_completion = ['<C-N>']
let g:ycm_key_list_previous_completion = ['<C-P>']
let g:ycm_min_num_of_chars_for_completion = 1
" force general python instead of python2
let g:ycm_python_binary_path = 'python'
nnoremap <Leader>R :YcmCompleter RefactorRename

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" EasyMotion config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" map <Leader> <Plug>(easymotion-prefix) " doesn't seem to work

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" ctrlp config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlP'

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" bufexplorer config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" let g:bufExplorerSortBy='number' " let's try mru for a bit
" autocmd VimEnter * nunmap <Leader>be " Unmap be, more annoying version of bt
let g:bufExplorerSplitRight=0
let g:bufExplorerVertSize=40
let g:bufExplorerBelow=1
let g:bufExplorerVertSize=10
nunmap <Leader>bv
nunmap <Leader>be
nunmap <Leader>bs
nunmap <Leader>bt
nnoremap <Leader>v :BufExplorerVerticalSplit<CR>
nnoremap <Leader>s :BufExplorerHorizontalSplit<CR>
nnoremap <Leader>b :BufExplorer<CR>

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" bufexplorer config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout=2
let g:undotree_SplitWidth=40

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" NERDTree config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
nnoremap <Leader>t :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
            \ && b:NERDTree.isTabTree()) | q | endif

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" autoclose config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
let g:autoclose_vim_commentmode = 1

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" tagbar config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
nmap <Leader>g :TagbarToggle<CR>
