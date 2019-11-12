set tw=0
nmap <C-]> :exec 'silent ! brave-beta https://arxiv.org/abs/' . matchlist(getline('.'), 'arXiv:\(\S\+\)')[1]<CR><C-L>
