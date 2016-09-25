" VIM: set rnu
" modelines
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

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" built in config options
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

set backspace=2 " allows deletion of newlines, automatic indentation
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

" statusline
set laststatus=2            " always statusbar
set statusline=%{getcwd()}: " pwd of vim
set statusline+=\ %f%m%=    " relative path to filename, modified flag, RHS
set statusline+=%c,         " char number
set statusline+=%l/%L\ %y   " curr line/total line [filetype]

" if persistent_undo, configure a directory for it
if has("persistent_undo")
    set undodir=$HOME/.undodir/
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
imap <S-Tab> <Tab>

" unmap stuff
map <F1> <Nop>
map Q <Nop>
imap <F1> <Nop>
vmap <F1> <Nop>
inoremap <C-U> <Nop>

" close any preview & help windows
nnoremap <Leader>h :pc<CR>:helpclose<CR>

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
autocmd BufNewFile Makefile silent! 0r ~/.vim/temps/Makefile
" remove trailing whitespace on exit
autocmd BufWritePre * %s/\s\+$//e

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" functions
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" list of triggers (normal mode only)
" gcc - commentary comment out
" gs/ys/cs - vim-surround
" <C-P> - ctrlp
" <Leader>a - tabularize
" <Leader>b - bufexplorer
" <Leader>c[lv] - latex keybindings
" <Leader>c[npq] - quickfix keybindings
" <Leader>f[tsmi] - fold method keybindings
" <Leader>g - tagbar toggle
" <Leader>h - close preview/scratch
" <Leader>l[npq] - location list keybindings
" <Leader>t - nerdtree
" <Leader>u - undotree
" <Leader>R - YCM refactor
" <Leader><Leader>w - Easymotion move

" folding
function ToggleFoldmethod()
    if &foldmethod ==? "manual"
        set foldmethod=indent " default foldmethod when starting vim
    else
        set foldmethod=manual
    endif
endfunction
call ToggleFoldmethod() " toggles from manual, default before vimrc

nnoremap <Leader>ft :call ToggleFoldmethod()<CR>
nnoremap <Leader>fm :set foldmethod=manual<CR>
nnoremap <Leader>fi :set foldmethod=indent<CR>
nnoremap <Leader>fs :set foldmethod=syntax<CR>

nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>
nnoremap <Leader>ll :ll<CR>

nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
nnoremap <Leader>cl :cc<CR>

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

" recommended syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ignore messages
let g:syntastic_quiet_messages = { "regex": 'terminated with space\|' .
            \ 'between a pair of\|better written in dot\|' .
            \ 'cell-var-from-loop\|' . 'broad-except\|' .
            \ 'enclose the previous parenthesis\|' .
            \ 'too-many-arguments' }

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
let g:ctrlp_custom_ignore = 'venv\|node_modules\|git'

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" bufexplorer config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" let g:bufExplorerSortBy='number' " let's try mru for a bit
let g:bufExplorerSplitRight=0
let g:bufExplorerVertSize=40
let g:bufExplorerBelow=1
let g:bufExplorerVertSize=10
nnoremap <Leader>v :BufExplorerVerticalSplit<CR>
nnoremap <Leader>s :BufExplorerHorizontalSplit<CR>
nnoremap <Leader>b :ToggleBufExplorer<CR>

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
" autoclose vim if NERDTree is last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
            \ && b:NERDTree.isTabTree()) | q | endif

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" autoclose config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
let g:autoclose_vim_commentmode = 1

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" tagbar config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
nnoremap <Leader>g :TagbarToggle<CR>
let g:tagbar_width=40

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" tabular config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
noremap <Leader>a :Tab /

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" argumentative config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
nmap >. >,
