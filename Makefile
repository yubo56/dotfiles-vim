# Makefile to install vim plugins
all: all_plugins ycm

# submodule update all plugins!
all_plugins:
	git submodule init
	git submodule update --init --recursive

# currently not configured to use libclang, so no semantic support of C-family
# libraries. Tradeoff is that install is easy
YCM_TEMP = ~/ycm_build
VIM_PATH = ~/.vim/bundle
CMAKE_PATH := $(shell command -v cmake 2> /dev/null)

ycm:
ifndef CMAKE_PATH
	echo 'cmake required' && exit 1
else
	mkdir -p ${YCM_TEMP}
	@echo "***Building YouCompleteMe temp files***"
	@cd ${YCM_TEMP} && \
		cmake -G "Unix Makefiles" . ${VIM_PATH}/YouCompleteMe/third_party/ycmd/cpp && \
		cmake --build . --target ycm_core
	rm -rf ${YCM_TEMP}
endif
