set tw=0
if has('macunix')
    nmap <C-]> :exec 'silent ! open https://arxiv.org/pdf/' . matchlist(getline('.'), 'arXiv:\(\S\+\)')[1] . '.pdf'<CR><C-L>
else
    nmap <C-]> :exec 'silent ! brave-beta https://arxiv.org/pdf/' . matchlist(getline('.'), 'arXiv:\(\S\+\)')[1] . '.pdf'<CR><C-L>
endif
let @/ = 'arXiv'
