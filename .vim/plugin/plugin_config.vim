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
    " {{{ Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    " recognize tex correctly
    let g:tex_flavor = "latex"

    " recommended syntastic options
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_loc_list_height = 3
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    " ignore messages
    let g:syntastic_quiet_messages = { "regex":
                \ 'terminated with space\|enclose the previous parenthesis\|' .
                \ 'between a pair of\|better written in dot\|' .
                \ 'consider-using-enumerate' .
                \ '\|cell-var-from-loop\|broad-except\|' .
                \ 'too-many-arguments\|too-many-locals\|too-many-branches\|' .
                \ 'too-few-public-methods' }

    " }}}
    " {{{ easyMotion config
    nmap <Leader>e <Plug>(easymotion-prefix)

    " }}}
    " {{{ Ctrlp config
    let g:ctrlp_map = '<C-P>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_prompt_mappings = {
        \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>', '<down>'],
        \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>', '<up>'],
        \ 'PrtHistory(-1)':       ['<c-b>', '<left>'],
        \ 'PrtHistory(1)':        ['<c-f>', '<right>'],
        \ }
    let g:ctrlp_custom_ignore = 'venv\|node_modules\|git'

    " }}}
    " {{{ Bufexplorer config
    " let g:bufExplorerSortBy='number' " let's try mru for a bit
    let g:bufExplorerSplitRight=0
    let g:bufExplorerVertSize=40
    let g:bufExplorerBelow=1
    let g:bufExplorerVertSize=10
    nnoremap <Leader>v :BufExplorerVerticalSplit<CR>
    nnoremap <Leader>s :BufExplorerHorizontalSplit<CR>
    nnoremap <Leader>b :ToggleBufExplorer<CR>

    " }}}
    " {{{ Undotree config
    nnoremap <Leader>u :UndotreeToggle<CR>
    let g:undotree_WindowLayout=2
    let g:undotree_SplitWidth=40

    " }}}
    " {{{ NERDTree config
    let g:NERDTreeDirArrowExpandable="+"
    let g:NERDTreeDirArrowCollapsible="~"
    nnoremap <Leader>t :NERDTreeToggle<CR>
    " autoclose vim if NERDTree is last buffer
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
                \ && b:NERDTree.isTabTree()) | q | endif

    " }}}
    " {{{ Autoclose config
    let g:autoclose_vim_commentmode = 1

    " }}}
    " {{{ Tagbar config
    nnoremap <Leader>g :TagbarToggle<CR>
    let g:tagbar_width=40
    let g:tagbar_show_linenumbers=1
    let g:tagbar_type_make = {
        \ 'kinds' : [
            \ 't:targets',
            \ 'm:macros',
        \ ],
    \ }
    let g:tagbar_type_tex = {
        \ 'ctagstype' : 'latex',
        \ 'kinds'     : [
            \ 's:foo',
            \ 'l:labels',
        \ ],
        \ 'sort'    : 0,
    \ }

    " }}}
    " {{{ Tabular config
    noremap <Leader>a :Tab /

    " }}}
    " {{{ Argumentative config
    nmap >. >,
    " }}}
endif
