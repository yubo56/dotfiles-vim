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
noremap <Leader>g :exec 'silent ! sed -i -n "/^\!/p" ' . expand('%:r') . '.log'<cr><C-L>
noremap <Leader>h :e %:r.log<cr>

" correct some timing bugs
inoremap `` ``
inoremap `~ `~
inoremap `- `-
inoremap `< `<
inoremap `> `>
inoremap [+ [+

" various alphabetic substitutions
imap ... \dots
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
