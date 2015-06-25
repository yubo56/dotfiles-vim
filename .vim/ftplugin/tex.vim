" LaTeX filetype
" "   Language: LaTeX (ft=tex)
"

" only tex no rnu
autocmd BufRead,BufNewFile *.tex set nornu
" without vimlatex, set folding rule
set foldmethod=syntax

" mimic vimlatex markers, handy
noremap <C-H> /\[++\]<cr>c%
inoremap <C-H> <ESC>/\[++\]<cr>c%


" compile/view launch
noremap <Leader>l :!pdflatex -interaction=nonstopmode %<cr>
noremap <Leader>v :exec 'silent ! zathura --fork ' . expand('%:r') . '.pdf'<cr>

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
