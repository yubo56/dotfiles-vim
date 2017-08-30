syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}"
syn match texInputFile "\\lstinline\s*\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt
