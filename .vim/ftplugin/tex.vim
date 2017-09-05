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
" syntax off

" {{{ Compile/viewing bindings
" cc compiles w/ current make, cp[x] sets current to pdflatex[xelatex] and
" calls cc
command! Compile make | cwindow 3

fun! SetMake(cmd)
    " if we have a Makefile in the current directory, defer to that
    if filereadable("Makefile")
        let &makeprg='make ' . expand('%:r') . '.pdf'
    else
        let &makeprg='compiletex ' . expand('%:r') . ' ' . a:cmd
    endif
endf
fun! CompileWith(cmd)
    call SetMake(a:cmd)
    Compile
endf

set errorformat=%f:%l:\ %m
call SetMake('pdflatex')
noremap <buffer> <Leader>cc :Compile <cr><C-L>
noremap <buffer> <Leader>cp :call CompileWith('pdflatex') <cr><C-L>
noremap <buffer> <Leader>cx :call CompileWith('xelatex') <cr><C-L>
if empty(matchstr($HOME, 'User')) " means on Linux not OS X
    " silent means don't need to press enter on complete,  means
    " automatically resets screen
    noremap <buffer> <Leader>cv :exec 'silent ! zathura --fork ' . expand('%:r') . '.pdf'<cr>
else
    noremap <buffer> <Leader>cv :exec 'silent ! open ' . expand('%:r') . '.pdf'<cr>
endif
noremap <buffer> <Leader>cg :e %:r.log<cr>
" }}}
" {{{ imaps <buffer>
" correct some timing bugs
inoremap <buffer> `` ``
inoremap <buffer> `~ `~
inoremap <buffer> `- `-
inoremap <buffer> `< `<
inoremap <buffer> `> `>
inoremap <buffer> [+ [+

" various alphabetic substitutions
inoremap <buffer> ... \dots
inoremap <buffer> `a \alpha
inoremap <buffer> `b \beta
inoremap <buffer> `c \chi
inoremap <buffer> `d \delta
inoremap <buffer> `e \epsilon
inoremap <buffer> `E \varepsilon
inoremap <buffer> `f \phi
inoremap <buffer> `T \partial
inoremap <buffer> `R \varphi
inoremap <buffer> `g \gamma
inoremap <buffer> `h \eta
inoremap <buffer> `i \iota
inoremap <buffer> `k \kappa
inoremap <buffer> `l \lambda
inoremap <buffer> `m \mu
inoremap <buffer> `n \nu
inoremap <buffer> `p \pi
inoremap <buffer> `q \theta
inoremap <buffer> `r \rho
inoremap <buffer> `s \sigma
inoremap <buffer> `t \tau
inoremap <buffer> `u \upsilon
inoremap <buffer> `w \omega
inoremap <buffer> `x \xi
inoremap <buffer> `y \psi
inoremap <buffer> `z \zeta
inoremap <buffer> `D \Delta
inoremap <buffer> `F \Phi
inoremap <buffer> `P \Pi
inoremap <buffer> `G \Gamma
inoremap <buffer> `Q \Theta
inoremap <buffer> `L \Lambda
inoremap <buffer> `X \Xi
inoremap <buffer> `Y \Psi
inoremap <buffer> `S \Sigma
inoremap <buffer> `U \Upsilon
inoremap <buffer> `W \Omega

" other ` substitutions
inoremap <buffer> `\| \Bigg\|
inoremap <buffer> `& \cdot
inoremap <buffer> `* \times
inoremap <buffer> `8 \infty
inoremap <buffer> `N \nabla
inoremap <buffer> `H \hbar
inoremap <buffer> `, \propto
inoremap <buffer> `+ ^\dagger

" other substitutions, not `
inoremap <buffer> --> \to
inoremap <buffer> ---> \longrightarrow
inoremap <buffer> -+ \mp
inoremap <buffer> ~= \approx
inoremap <buffer> ~~ \sim
inoremap <buffer> >> \gg
inoremap <buffer> << \ll
inoremap <buffer> >= \geq
inoremap <buffer> <= \leq
inoremap <buffer> != \neq
inoremap <buffer> +- \pm
inoremap <buffer> ** \item
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
