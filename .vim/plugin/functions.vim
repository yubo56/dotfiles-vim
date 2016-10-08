" vim: fdm=marker
"
" {{{ folding
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
" }}}
" {{{ ctags
function! UpdateCtags()
    " only update if ctags file is found
    let tagsfile=findfile(".tags", ".;")
    if tagsfile !=? ''
        let tagspath=fnamemodify(tagsfile, ':h')
        let log=system("cd " . tagspath . " && ctags . &")
        if v:shell_error != 0
            echo "ctags update failed on: " . log
        endif
    endif
endfunction
" }}}
