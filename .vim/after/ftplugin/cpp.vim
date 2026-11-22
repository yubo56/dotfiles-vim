if $NO_PLUGIN !=? "TRUE" && executable('clangd')
    setlocal omnifunc=ale#completion#OmniFunc
endif
