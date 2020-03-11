" vim: fdm=marker
" Language: LaTeX (ft=tex)
" LaTeX filetype
"

" without vimlatex, set folding rule
setlocal foldmethod=indent

" indentation configuration
let g:tex_noindent_env = 'document\|verbatim\|lstlisting'

" autowrap
setlocal tw=80

" syntax highlighting in large files is especially slow
" syntax off

" {{{ Compile/viewing bindings
" cc compiles w/ current make, cp[x] sets current to pdflatex[xelatex] and
"       calls cc
" Dynamically updates to current buffer every cc
fun! SetTex(name)
    let g:tex_cmd=a:name
endf
fun! SetMake()
    " if we have a Makefile in the current directory, defer to that
    if filereadable("Makefile")
        let &makeprg='make ' . expand('%:r') . '.pdf'
    else
        let &makeprg='compiletex ' . expand('%:r') . ' ' . g:tex_cmd
    endif
endf
fun! Compile()
    call SetMake()
    Make
endf
fun! CompileWith(cmd)
    call SetTex(a:cmd)
    call Compile()
endf

setlocal errorformat=%f:%l:\ %m
call SetTex('pdflatex')
noremap <buffer> <Leader>cc :call Compile() <cr><C-L>
noremap <buffer> <Leader>cp :call CompileWith('pdflatex') <cr><C-L>
noremap <buffer> <Leader>cx :call CompileWith('xelatex') <cr><C-L>
if empty(matchstr($HOME, 'User')) " means on Linux not OS X
    " silent means don't need to press enter on complete, <C-L> means
    " automatically resets screen
    noremap <buffer> <Leader>cv :exec 'silent ! zathura --fork ' . expand('%:r') . '.pdf'<cr><C-L>
else
    noremap <buffer> <Leader>cv :exec 'silent ! open ' . expand('%:r') . '.pdf'<cr><C-L>
endif
noremap <buffer> <Leader>cg :e %:r.log<cr>
" }}}
" {{{ imaps <buffer>
" correct some timing bugs
inoremap <buffer> `` ``
inoremap <buffer> \` \`
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
inoremap <buffer> `& \cdot
inoremap <buffer> `* \times
inoremap <buffer> `8 \infty
inoremap <buffer> `N \nabla
inoremap <buffer> `H \hbar
inoremap <buffer> `, \propto
inoremap <buffer> `+ ^\dagger

" other substitutions, not `
inoremap <buffer> \: \colon
inoremap <buffer> --> \to
inoremap <buffer> <--> \leftrightarrow
inoremap <buffer> <==> \Leftrightarrow
inoremap <buffer> ==> \Rightarrow
inoremap <buffer> ---> \longrightarrow
inoremap <buffer> -+ \mp
inoremap <buffer> ~= \approx
inoremap <buffer> =~ \simeq
inoremap <buffer> ~< \lesssim
inoremap <buffer> ~> \gtrsim
inoremap <buffer> ~~ \sim
inoremap <buffer> >> \gg
inoremap <buffer> << \ll
inoremap <buffer> >= \geq
inoremap <buffer> <= \leq
inoremap <buffer> != \neq
inoremap <buffer> +- \pm
inoremap <buffer> ** \item
inoremap <buffer> nn\\ \nonumber\\
inoremap <buffer> %9 % chktex 9
" }}}
" {{{ user-completion autocompletes labels
fun! CompleteRefs(findstart, base)
    " first invocation returns -1 or index of char after 'ref{' sequence
    " second invocation checks whether base == 'ref{' before returning list of
    "       \label{(.*)} matches
    if a:findstart
        " match returns -1 if not found, which cancels completion
        let m = match(getline('.'), 'ref{')
        if m == -1
            return -1
        endif

        " keep searching while next match is != -1 and is left of curr col
        while match(getline('.'), 'ref{', m + 1) != -1 && m < col('.')
            let m = match(getline('.'), 'ref{', m + 1)
        endw
        return m + 4 " return index after 'ref{'
    else
        " a:base is what currently exists in the completion
        let lbls = []
        let linenr = 1
        while linenr <= line("$")
            let linematch = matchlist(getline(linenr), '\\label{\(' . a:base . '[^}]*\)}')
            if !empty(linematch)
                call add(lbls, linematch[1])
            endif
            let linenr += 1
        endwhile
        return lbls
    endif
endf

fun! _beamer()
    %d
    0r $HOME/.vim/temps/beamer_temp.tex
endf
cnoremap BEAM call _beamer()

setlocal completefunc=CompleteRefs
" }}}
" macros {{{
let @p = "i\\p\<Esc>lma%r}`ar{"
" }}}
