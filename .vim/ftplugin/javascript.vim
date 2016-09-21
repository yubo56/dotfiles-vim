" record a couple of macros
" f, g = temporary register

" settings
set tabstop=2
set softtabstop=2
set shiftwidth=2

" reset highlight for Blend style
set cc=121

" split up a console.log(a, b, c) into separate lines
let @c = "f,s);\<CR>console.log(\<ESC>"

" remove all *.only from the file
let @o = "mfHmg:%s/\.only\(/\(/g\<CR>'gzt'f"

" put .only on leading describe
let @d = "mfHmg:%s/^describe\(/describe.only\(/g\<CR>'gzt'f"

" put .only on 'it' just before
let @b = "mfHmg'f?it(\<CR>cwit.only\<ESC>'gzt'f"

" find local eslint
let s:lcd = fnameescape(getcwd())
silent! exec "lcd" expand('%:p:h')
" need to find blend/node_modules when npm bin points to
" blend/backend/node_modules
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
exec "lcd" s:lcd
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path,
            \'^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" use eslint if found
if b:syntastic_javascript_eslint_exec == "eslint not found"
    let g:syntastic_javascript_checkers = ['jshint']
else
    let g:syntastic_javascript_checkers = ['eslint']
endif
