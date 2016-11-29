" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
" use tabs using <C-W> similar to windows in tmux
" swap windows are ^W[hljk], send is ^W[HLJK]
" ^Wt selects first window
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
nnoremap <C-W>t :let g:tab_names_use_filenames =
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
