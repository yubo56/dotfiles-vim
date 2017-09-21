" listings highlighting
syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}"
syn match texInputFile "\\lstinline\s*\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt

" ugh the bundled tex.vim one does not amke sense
syn clear texBadMath
syn match texBadMath "\\end\s*{\s*\(align\|alignat\|displaymath\|displaymath\|eqnarray\|equation\|flalign\|gather\|math\|multline\|xalignat\)\*\=\s*}"
syn match texBadMath "\\[\])]"

" highlight autoref correctly
syn region texRefZone matchgroup=texStatement start="\\autoref{" end="}\|%stopzone\>" contains=@texRefGroup

" give newcommand* the same treatment as newcommand
syn match texNewCmd "\\newcommand\>\*" nextgroup=texCmdName skipwhite skipnl
