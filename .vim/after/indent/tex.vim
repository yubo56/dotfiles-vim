" # Rules
" - begin's should always align w/ their ends
" - verbatim: always return current indentation
" - itemize: if =~ \item, single indent, else double indent
" - align: for every line of the equation (delimited by trailiing (\\|&)), leading
"       line is single indent, everything else is double
"   - if a line starts with an alignment char (&), everything until end of line
"       character gets a further indentation
" - all other envs = +1 indentation
" - All matched characters (), [], {}, \left.\right., induce an extra indent until
"   closed
"
" # Functions
" - GetClosestEnv
" - GetPrevLine
" - Indent(env_name)
" - IndentByPrev(prev_line)
"
" - GetIndent() - returns Indent + IndentByPrev
"
set indentexpr=
