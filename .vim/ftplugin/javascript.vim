" record a couple of macros
" f, g = temporary register

" settings
set tabstop=2
set softtabstop=2
set shiftwidth=2

" reset highlight for Blend style
" set cc=121
set cc=0

" remove all *.only from the file
let @o = "mfHmg:%s/\.only\(/\(/g\<CR>'gzt'f"

" put .only on leading describe
let @d = "mfHmg:%s/^describe\(/describe.only\(/g\<CR>'gzt'f"

" put .only on 'it' just before
let @b = "mfHmg'f?\\s\\+it(\<CR>wcwit.only\<ESC>'gzt'f"

" remove _.partial and turn into a cb =>
let @p = "0f_cf(cb => \<ESC>f,xr(%i, cb\<ESC>"

" To make eslint work w/ plugins, just need to globally install plugin, point
" eslint symlink in $PATH to subdirectory of plugin
let g:syntastic_javascript_checkers = ['eslint']

set include=^const.*=.*require
set suffixesadd=.js

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
