" vim: fdm=marker
"
if $NO_PLUGIN !=? "TRUE"
    " {{{ Ultisnips
    " Trigger configuration
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<C-J>"
    let g:UltiSnipsJumpBackwardTrigger="<C-K>"
    " :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
    " }}}
    " recognize tex correctly
    let g:tex_flavor = "latex"

    " {{{ Ale
    " open the loclist when there are problems, 3 lines tall
    let g:ale_open_list = 1
    let g:ale_list_window_size = 3

    " 'perl' runs BEGIN blocks, so ALE leaves it off unless listed explicitly
    " clangd reads compile_commands.json + .clangd from the repo root;
    " standalone clang-tidy chokes on the gcc flags in compile_commands.json
    let g:ale_linters = {
        \ 'cpp': ['clangd'],
        \ 'perl': ['perl'],
        \ 'tex': ['chktex'],
        \ }
    let g:ale_tex_chktex_options = '-I -n8 -n1 -n37'
    " }}}
    " {{{ easyMotion config
    nmap <Leader>e <Plug>(easymotion-prefix)

    " }}}
    " {{{ Ctrlp config
    let g:ctrlp_map = '<C-P>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_prompt_mappings = {
        \ 'PrtSelectMove("j")':   ['<down>'],
        \ 'PrtSelectMove("k")':   ['<up>'],
        \ 'PrtHistory(-1)':       ['<c-f>', '<right>'],
        \ 'PrtHistory(1)':        ['<c-b>', '<left>'],
        \ 'PrtCurLeft()':         [],
        \ 'PrtCurRight()':        [],
        \ 'PrtSelectMove("t")':   [],
        \ 'PrtSelectMove("b")':   [],
        \ 'PrtCurStart()':        ['<Home>'],
        \ 'PrtCurEnd()':          ['<End>']
        \ }
    " default CurLeft/Right kills arrow key, use Home/End to move cursor,
    " SelectMove(t/b) previously occupied home key
    let g:ctrlp_custom_ignore = 'venv$\|node_modules$\|git$\|dist$\|dev$' .
                \ '\|build$\|jestCache$\|repos\|coverage.*$'

    " }}}
    " {{{ Bufexplorer config
    " let g:bufExplorerSortBy='number' " let's try mru for a bit
    let g:bufExplorerSplitRight=0
    let g:bufExplorerVertSize=40
    let g:bufExplorerBelow=1
    let g:bufExplorerVertSize=10
    " nnoremap <Leader>v :BufExplorerVerticalSplit<CR>
    " nnoremap <Leader>s :BufExplorerHorizontalSplit<CR>
    nnoremap <Leader>b :ToggleBufExplorer<CR>

    " }}}
    " {{{ Undotree config
    nnoremap <Leader>u :UndotreeToggle<CR>
    let g:undotree_WindowLayout=2
    let g:undotree_SplitWidth=40

    " }}}
    " {{{ NERDTree config
    " let g:NERDTreeDirArrowExpandable="+"
    " let g:NERDTreeDirArrowCollapsible="~"
    nnoremap <Leader>t :NERDTreeToggle<CR>
    " autoclose vim if NERDTree is last buffer
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
                \ && b:NERDTree.isTabTree()) | q | endif

    " }}}
    " {{{ Tagbar config
    nnoremap <Leader>g :TagbarToggle<CR>
    let g:tagbar_width=60
    let g:tagbar_show_linenumbers=2
    let g:tagbar_autoclose=1
    let g:tagbar_compact=1
    let g:tagbar_type_make = {
        \ 'kinds' : [
            \ 't:targets',
            \ 'm:macros',
        \ ],
    \ }
    " }}}
    " {{{ Tabular config
    noremap <Leader>a :Tab /

    " }}}
    " {{{ Argumentative config
    nmap >. >,
    " }}}
endif
