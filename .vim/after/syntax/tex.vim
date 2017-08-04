syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}"
syn match texInputFile "\\lstinline\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt
