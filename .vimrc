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
" show opening operator when closing
set showmatch

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

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" keybindings
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" paste mode toggle
set pastetoggle=<F12>
" <F8> but not actually a function key?
map [19~ <C-W>
" reload vimrc
nnoremap <C-W><C-R> :so $MYVIMRC<CR>

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
" use tabs using <C-W> similar to windows in tmux
" swap windows are ^W[hljk], send is ^W[HLJK]
" ^Wt selects first window
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" nnoremap <C-W>n to custom function below
nnoremap <C-W>x :tabclose<CR>
nmap <C-W>! <C-W>T
nnoremap <C-W>[ gT
nnoremap <C-W>] gt
nnoremap <C-W>] gt
nnoremap <C-W><Left> :-tabmove<CR>
nnoremap <C-W><C-B> :-tabmove<CR>
nnoremap <C-W><Right> :+tabmove<CR>
nnoremap <C-W><C-F> :+tabmove<CR>

" jump windows by number like tmux
nnoremap <C-W>1 1gt
nnoremap <C-W>2 2gt
nnoremap <C-W>3 3gt
nnoremap <C-W>4 4gt
nnoremap <C-W>5 5gt
nnoremap <C-W>6 6gt
nnoremap <C-W>7 7gt
nnoremap <C-W>8 8gt
nnoremap <C-W>9 9gt

nnoremap <C-W>n :call NewTabFast() <CR>
nnoremap <C-W>N :call NewTabInteractive() <CR>
nnoremap <C-W>, :call NameTab(tabpagenr()) <CR>
" toggles whether to use filenames or custom names
"       throws in a redraw to instantly update
nnoremap <C-W>q :let g:tab_names_use_filenames =
            \ !g:tab_names_use_filenames <CR><C-L>

" opens up a new tab w/ name 'x'
function! NewTabFast()
    let t = tabpagenr()
    if t < len(g:tab_names)
        let g:tab_names[t] = 'x'
    else
        let g:tab_names += ['x']
    endif
    execute "tabnew"
endfunction
" names tab a:tabnum interactively
function! NameTab(tabnum)
    " vimscript tabs are 1-indexed but lists are 0-indexed
    let tabnum = a:tabnum - 1

    " Have to do this inputsave/inputrestore for some reason,
    "   http://vim.wikia.com/wiki/User_input_from_a_script
    call inputsave()
    let name = input('tab name: ')
    call inputrestore()
    if tabnum < len(g:tab_names)
        let g:tab_names[tabnum] = name
    else
        let g:tab_names += [name]
    endif

    " redraw so get new names
    execute "redraw!"
endfunction
" opens a new tab and names w/ NameTab() dialog
function! NewTabInteractive()
    call NameTab(tabpagenr() + 1)
    execute "tabnew"
endfunction

" show tab numbers, with two naming schemes
let g:tab_names_use_filenames = 1

" set g:tab_names with a default value (since vimrc is sourced every time)
"   current naming scheme assumes no more than one new tab opened at once
let g:tab_names = get(g:, 'tab_names', ['main'])
function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        " color the tab number and number of windows w/ regular fill
        let s .= '%#TabLineFill# '
        let s .= i
        let s .= '(' . tabpagewinnr(i,'$') . '): '
        " color filename w/ selected fill
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        if g:tab_names_use_filenames == 1
            " if using filenames and buftype indicates normal file, just name
            "   per filename or [No Name]
            " else, name per buftype
            let bufnr = buflist[winnr - 1]
            let tabname = bufname(bufnr)
            let buftype = getbufvar(bufnr, '&buftype')
            if buftype == ''
                if tabname == ''
                    let tabname = '[No Name]'
                else
                    let tabname = fnamemodify(tabname, ':~:.')
                endif
            else
                let tabname = buftype
            endif
        else
            " fetch from global variable
            let tabname = get(g:tab_names, i - 1, 'x')
        endif
        " add on computed filename
        let s .= tabname
        let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    " put cwd and date and time in top right
    let s .= 'cwd: '
    let s .= getcwd()
    return s
endfunction
set tabline=%!MyTabLine()

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
" <Leader>e - easymotion prefix [wb]
" <Leader>f[tsmi] - fold method keybindings
" <Leader>g - tagbar toggle
" <Leader>h - close preview/scratch
" <Leader>l[npq] - location list keybindings
" <Leader>t - nerdtree
" <Leader>u - undotree
" <Leader>R - YCM refactor
" <Leader><Leader>w - Easymotion move

" folding
function! ToggleFoldmethod()
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
nnoremap <Leader>lq :lclose<CR>

nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
nnoremap <Leader>cl :cc<CR>
nnoremap <Leader>cq :cclose<CR>

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" ultisnips
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" Trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-L>"
let g:UltiSnipsJumpBackwardTrigger="<C-H>"
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
let g:syntastic_quiet_messages = { "regex":
            \ 'terminated with space\|enclose the previous parenthesis\|' .
            \ 'between a pair of\|better written in dot\|' .
            \ 'cell-var-from-loop\|' . 'broad-except\|' .
            \ 'too-many-arguments\|too-many-locals\|too-many-branches\|' .
            \ 'too-few-public-methods' }

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" YouCompleteMe config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

let g:ycm_key_list_select_completion = ['<C-N>']
let g:ycm_key_list_previous_completion = ['<C-P>']
let g:ycm_min_num_of_chars_for_completion = 1
" force general python instead of python2
let g:ycm_python_binary_path = 'python'
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'vim' : 1,
      \ 'latex' : 1
      \}
nnoremap <Leader>R :YcmCompleter RefactorRename

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" EasyMotion config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
nmap <Leader>e <Plug>(easymotion-prefix)

" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" ctrlp config
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>', '<up>'],
    \ 'PrtHistory(-1)':       ['<c-b>', '<left>'],
    \ 'PrtHistory(1)':        ['<c-f>', '<right>'],
    \ }
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
