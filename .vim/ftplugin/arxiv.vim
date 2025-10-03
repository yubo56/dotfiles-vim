set sw=4
set fdm=indent

nmap <C-]> jjmaYGpdaW`a:exec 'silent ! wget -q -nc ' . matchlist(getline('.'), 'Link: \(\S\+\)')[1] . ' -P pdf/' . @%  . '&' <CR><C-L>kkzt
nmap <C-O> :exec 'silent ! zathura pdf/' . @% . '/* &' <CR><C-L>
nmap <C-G> :exec 'silent ! xdg-open ' . substitute(matchlist(getline('.'), 'Link: \(\S\+\)')[1], 'pdf', 'abs', 'g') <CR><C-L>
let @/ = 'Title:'
let @q = 'nzt'
