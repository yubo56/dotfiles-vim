set tw=0
set sw=4
set fdm=indent

nmap <C-]> :exec 'silent ! wget -q ' . matchlist(getline('.'), 'Link: \(\S\+\)')[1] . ' -P pdf/' . @% <CR><C-L>
let @/ = 'Link:'
