set tw=0
if has('macunix')
    nmap <C-]> :exec 'silent ! open https://arxiv.org/abs/' . matchlist(getline('.'), 'arXiv:\(\S\+\)')[1]<CR><C-L>
else
    nmap <C-]> :exec 'silent ! brave-beta https://arxiv.org/abs/' . matchlist(getline('.'), 'arXiv:\(\S\+\)')[1]<CR><C-L>
endif
