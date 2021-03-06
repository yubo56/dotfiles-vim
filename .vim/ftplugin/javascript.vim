" record a couple of macros
" f, g = temporary register

" settings
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal tw=120

" reset highlight for Blend style
" set cc=121
setlocal cc=0

" remove all *.only from the file
let @o = "mfHmg:%s/\.only\(/\(/g\<CR>'gzt'f"

" put .only on leading describe
let @d = "mfHmg:%s/^describe\(/describe.only\(/g\<CR>'gzt'f"

" put .only on 'it/describe' just before
let @b = "mfHmg'f?\\s\\+it(\<CR>wcwit.only\<ESC>'gzt'f"
let @h = "mfHmg'f?describe(\<CR>cwdescribe.only\<ESC>'gzt'f"

" remove _.partial and turn into a cb =>
let @p = "0f_cf(cb => \<ESC>f,xr(%i, cb\<ESC>"

" To make eslint work w/ plugins, just need to globally install plugin, point
" eslint symlink in $PATH to subdirectory of plugin

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = []

fun! SetupTS()
    setlocal tw=160
    let g:syntastic_filetype_map = { "javascript": "typescript" }
    if expand('%:p') =~ "blend.*/backend/lib"
        let g:syntastic_typescript_tslint_args = '--project ~/blend/backend/tsconfig.json --config ~/blend/backend/tslint.js'
    else
        let g:syntastic_typescript_tslint_args = '--project ~/blend/backend/tsconfig.json --config ~/blend/backend/tslint.test.js'
    endif
endf
fun! SetupJS()
    setlocal tw=120
    let g:syntastic_filetype_map = {}
endf
autocmd BufEnter,BufReadPre  *.ts call SetupTS()
autocmd BufEnter,BufReadPre *.js call SetupJS()

setlocal include=^const.*=.*require
setlocal suffixesadd=.js

function! ToggleTslint()
    if g:syntastic_typescript_checkers ==? []
        let g:syntastic_typescript_checkers=['tslint']
    else
        let g:syntastic_typescript_checkers=[]
    endif
endfunction

nnoremap <F4> :call ToggleTslint() <CR>

" search node_modules too (unused since really slow)
" fun! IncludeExpr(file)
"     if (filereadable(a:file))
"         return a:file
"     else
"         return substitute(a:file, '\\.js', '/index.js', 'g')
"     endif
" endf
" set includeexpr=IncludeExpr(v:fname)
" set path+=/home/yssu/blend/backend/node_modules/*/index.js
