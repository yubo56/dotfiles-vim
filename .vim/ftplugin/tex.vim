" LaTeX filetype
" vim: fdm=marker
" Language: LaTeX (ft=tex)
"

" only tex no rnu, lags b/c absurd repeat rate
" set nornu
" without vimlatex, set folding rule
set foldmethod=indent

" indentation configuration
let g:tex_noindent_env = 'document\|verbatim\|lstlisting'

" autowrap
set tw=80

" syntax highlighting in large files is especially slow
syntax off

" {{{ Compile/viewing bindings
" cc compiles w/ current make, cp[x] sets current to pdflatex[xelatex] and
" calls cc
let g:latexPartialCommand=' -interaction=nonstopmode -file-line-error %' .
        \ '\| sed -E ' .
        \ '''s/(.*Warning:.*)on input line ([0-9]+)/.\/%:\2: \1/g''' .
        \ '\| grep ''^\./%'''
command! Compile make | cwindow 3

fun! SetMake(cmd)
    let &makeprg=a:cmd . g:latexPartialCommand
endf
fun! CompileWith(cmd)
    call SetMake(a:cmd)
    Compile
endf

set errorformat=%f:%l:\ %m
call SetMake('pdflatex')
noremap <Leader>cc :Compile <cr><C-L>
noremap <Leader>cp :call CompileWith('pdflatex') <cr><C-L>
noremap <Leader>cx :call CompileWith('xelatex') <cr><C-L>
    " silent means don't need to press enter on complete,  means
    " automatically resets screen
noremap <Leader>cv :exec 'silent ! zathura --fork ' . expand('%:r') . '.pdf'<cr>
noremap <Leader>cg :e %:r.log<cr>
" }}}
" {{{ imaps
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
inoremap ** \item
" }}}
" {{{ user-completion autocompletes labels
function! CompleteRefs(findstart, base)
    " first invocation (findstart=1) tries to backtrack 4 characters
    " second invocation checks whether base == 'ref{' before returning list of
    "       \label{(.*)} matches
    if a:findstart
        " if line is too short, truncate at -1
        return max([-1, col('.') - 5])
    else
        " if not empty base and base matches 'ref{' at index 0
        if !empty(a:base) && !match(a:base, 'ref{')
            let lbls = []
            let linenr = 1
            while linenr <= line("$")
                let linematch = matchlist(getline(linenr), '\\label{\([^}]*\)}')
                if !empty(linematch)
                    call add(lbls, a:base . linematch[1])
                endif
                let linenr += 1
            endwhile
            return lbls
        " else a:base is empty, empty return
        endif
    endif
endfunction

set completefunc=CompleteRefs
" }}}
