" LaTeX filetype
" "   Language: LaTeX (ft=tex)
"

" only tex no rnu, lags b/c absurd repeat rate
set nornu
" without vimlatex, set folding rule
set foldmethod=indent
" make sure <space> is mapped to self... danger!
imap <space> <space>
nmap <space> <space>

" mimic vimlatex markers, handy
noremap <C-S-F12> /\[++\]<cr>c%
inoremap <C-S-F12> <ESC>/\[++\]<cr>c%


" compile/view launch
noremap <Leader>l :silent ! pdflatex -interaction=nonstopmode %<cr><C-L>
    " silent means don't need to press enter,  means automatically resets
    " screen!
noremap <Leader>v :exec 'silent ! zathura --fork ' . expand('%:r') . '.pdf'<cr>
noremap <Leader>g :exec 'silent ! sed -i -n "/^\!/p" ' . expand('%:r') . '.log'<cr><C-L> |badd %:r.log

" various alphabetic substitutions
imap `a \alpha
imap `b \beta
imap `c \chi
imap `d \delta
imap `e \epsilon
imap `E \varepsilon
imap `f \phi
imap `g \gamma
imap `h \eta
imap `i \iota
imap `k \kappa
imap `l \lambda
imap `m \mu
imap `n \nu
imap `p \pi
imap `q \theta
imap `r \rho
imap `s \sigma
imap `t \tau
imap `u \upsilon
imap `w \omega
imap `x \xi
imap `y \psi
imap `z \zeta
imap `D \Delta
imap `F \Phi
imap `P \Pi
imap `G \Gamma
imap `Q \Theta
imap `L \Lambda
imap `X \Xi
imap `Y \Psi
imap `S \Sigma
imap `U \Upsilon
imap `W \Omega

" other ` substitutions
imap `\| \Bigg\|
imap `& \cdot
imap `* \times
imap `8 \infty
imap `N \nabla
imap `H \hbar
imap `, \propto
imap `+ \dagger

" other substitutions, not `
imap --> \to
imap -+ \mp
imap ~= \approx
imap ~~ \sim
imap >> \gg
imap << \ll
imap >= \geq
imap <= \leq
imap != \neq
imap +- \pm

" coordinated with UltiSnips
imap `< _snip_<<tab>
imap `C _snip_C<tab>
imap `J _snip_J<tab>
imap `K _snip_K<tab>
imap `3 _snip_3<tab>
imap `# _snip_#<tab>
imap `> _snip_><tab>
imap `6 _snip_6<tab>
imap `5 _snip_5<tab>
imap `B _snip_B<tab>
imap `v _snip_v<tab>
imap `V _snip_V<tab>
imap `j _snip_j<tab>
imap `% _snip_%<tab>
imap `^ _snip_^<tab>
imap `( _snip_(<tab>
imap `[ _snip_[<tab>
imap `I _snip_I<tab>
imap `_ _snip__<tab>
imap `/ _snip_/<tab>
imap `M _snip_M<tab>
imap `~ _snip_~<tab>
imap `; _snip_;<tab>
imap `: _snip_:<tab>
imap `2 _snip_2<tab>
imap CAL _snipcal_<tab>
imap SCN _snipscn_<tab>
imap LBL _sniplbl_<tab>
imap EQR _snipeqr_<tab>
imap REF _snipref_<tab>
imap __ _snipunder_<tab>
imap ^^ _snipover_<tab>
imap (( _snipparen_<tab>
imap [[ _snipsquare_<tab>
imap {{ _snipcurly_<tab>
imap \|\| _snipabs_<tab>
imap <> _snipdotp_<tab>
imap FEM _snipemph_<tab>
