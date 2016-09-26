" LaTeX filetype
" "   Language: LaTeX (ft=tex)
"

" only tex no rnu, lags b/c absurd repeat rate
" set nornu
" without vimlatex, set folding rule
set foldmethod=indent
" make sure <space> is mapped to self... danger!
nnoremap <space> <space>

" mimic vimlatex markers, handy
noremap <F11> /\[++\]<cr>c%
inoremap <F11> <ESC>/\[++\]<cr>c%

" autowrap
set tw=80

" compile/view launch
set makeprg=pdflatex\ -interaction=nonstopmode\ -file-line-error\ %\\\|grep\ \'^\\./%\'
set errorformat=%f:%l:\ %m
command QLmake make | cwindow 3
noremap <Leader>cc :QLmake <cr><C-L>
    " silent means don't need to press enter on complete,  means
    " automatically resets screen
noremap <Leader>cv :exec 'silent ! zathura --fork ' . expand('%:r') . '.pdf'<cr>
noremap <Leader>cg :e %:r.log<cr>

" correct some timing bugs
inoremap `` ``
inoremap `~ `~
inoremap `- `-
inoremap `< `<
inoremap `> `>
inoremap [+ [+

" various alphabetic substitutions
inoremap ... \dots
inoremap `a \alpha
inoremap `b \beta
inoremap `c \chi
inoremap `d \delta
inoremap `e \epsilon
inoremap `E \varepsilon
inoremap `f \phi
inoremap `T \partial
inoremap `R \varphi
inoremap `g \gamma
inoremap `h \eta
inoremap `i \iota
inoremap `k \kappa
inoremap `l \lambda
inoremap `m \mu
inoremap `n \nu
inoremap `p \pi
inoremap `q \theta
inoremap `r \rho
inoremap `s \sigma
inoremap `t \tau
inoremap `u \upsilon
inoremap `w \omega
inoremap `x \xi
inoremap `y \psi
inoremap `z \zeta
inoremap `D \Delta
inoremap `F \Phi
inoremap `P \Pi
inoremap `G \Gamma
inoremap `Q \Theta
inoremap `L \Lambda
inoremap `X \Xi
inoremap `Y \Psi
inoremap `S \Sigma
inoremap `U \Upsilon
inoremap `W \Omega

" other ` substitutions
inoremap `\| \Bigg\|
inoremap `& \cdot
inoremap `* \times
inoremap `8 \infty
inoremap `N \nabla
inoremap `H \hbar
inoremap `, \propto
inoremap `+ ^\dagger

" other substitutions, not `
inoremap --> \to
inoremap ---> \longrightarrow
inoremap -+ \mp
inoremap ~= \approx
inoremap ~~ \sim
inoremap >> \gg
inoremap << \ll
inoremap >= \geq
inoremap <= \leq
inoremap != \neq
inoremap +- \pm
inoremap \i \item
