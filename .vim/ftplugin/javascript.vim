" record a couple of macros
" f, g = temporary register

" settings
set tabstop=2
set softtabstop=2
set shiftwidth=2

" reset highlight for Blend style
" set cc=121
set cc=0

" split up a console.log(a, b, c) into separate lines
let @c = "f,s);\<CR>console.log(\<ESC>"

" remove all *.only from the file
let @o = "mfHmg:%s/\.only\(/\(/g\<CR>'gzt'f"

" put .only on leading describe
let @d = "mfHmg:%s/^describe\(/describe.only\(/g\<CR>'gzt'f"

" put .only on 'it' just before
let @b = "mfHmg'f?it(\<CR>cwit.only\<ESC>'gzt'f"

" To make eslint work w/ plugins, just need to globally install plugin, point
" eslint symlink in $PATH to subdirectory of plugin
let g:syntastic_javascript_checkers = ['eslint']
