" settings
" sudo cp /usr/share/vim/vim80/indent/{javascript.vim,typescript.vim}
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal tw=120

let g:syntastic_typescript_checkers = ['tslint']
fun! SetTslintArgs()
    if expand('%:p') =~ "blend.*/backend/lib"
        let g:syntastic_typescript_tslint_args = '--config ~/blend/backend/tslint.js'
    else
        let g:syntastic_typescript_tslint_args = '--config ~/blend/backend/tslint.test.js'
    endif
endf
autocmd BufEnter *.ts call SetTslintArgs()
