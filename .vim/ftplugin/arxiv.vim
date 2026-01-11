nnoremap <C-]> jjjmaYGpdaW`a:exec 'silent ! wget -q -nc ' . matchlist(getline('.'), 'Link: \(\S\+\)')[1] . ' -P pdf/' . @%  . '&' <CR><C-L>kkkzt
nnoremap <C-G> :exec 'silent ! xdg-open ' . substitute(matchlist(getline('.'), 'Link: \(\S\+\)')[1], 'pdf', 'abs', 'g') <CR><C-L>
nnoremap <C-P> :exec 'silent ! zathura pdf/' . @% . '/* &' <CR><C-L>
let @/ = 'Title:'
let @q = 'nzt'
set cc=0
