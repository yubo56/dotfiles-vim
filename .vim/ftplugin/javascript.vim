" record a couple of macros

" split up a console.log(a, b, c) into separate lines
let @c = "f,s);\<CR>console.log(\<ESC>"

" remove all *.only from the file
let @o = ":%s/\.only//g\<CR>"

" put .only on leading describe
let @d = ":%s/^describe\(/describe.only\(/g\<CR>"

" put .only on 'it' just before
let @b = "?it(\<CR>cwit.only\<ESC>"
