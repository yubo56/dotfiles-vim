set tw=0
set sw=4
set fdm=indent

nmap <C-]> maYGpdaW`a:exec 'silent ! wget -q -nc ' . matchlist(getline('.'), 'Link: \(\S\+\)')[1] . ' -P pdf/' . @% <CR><C-L>
nmap <C-O> :exec 'silent ! zathura pdf/' . @% . '/* &' <CR><C-L>
let @/ = 'Link:'
