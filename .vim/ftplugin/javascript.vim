" record a couple of macros
" f = temporary register

" split up a console.log(a, b, c) into separate lines
let @c = "f,s);\<CR>console.log(\<ESC>"

" remove all *.only from the file
let @o = "mf:%s/\.only//g\<CR>'f"

" put .only on leading describe
let @d = "mf:%s/^describe\(/describe.only\(/g\<CR>'f"

" put .only on 'it' just before
let @b = "mf?it(\<CR>cwit.only\<ESC>'f"
