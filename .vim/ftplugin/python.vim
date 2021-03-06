setlocal tw=80
let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'
let g:syntastic_python_checkers=['python']

function! TogglePythonChecker()
    if g:syntastic_python_checkers ==? ['python']
        let g:syntastic_python_checkers=['python', 'pylint']
    else
        let g:syntastic_python_checkers=['python']
    endif
endfunction

let @p = "a'=====\<C-R>=expand('%')\<CR>=====', \<ESC>"

nnoremap <F4> :call TogglePythonChecker() <CR>
