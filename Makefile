# Makefile to install vim plugins
all: init_plugins update_plugins ycm

# submodule update all plugins!
init_plugins:
	git submodule init

# separate target in case we learn more about this process and want to add to it
update_plugins:
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
	rm -rf ${YCM_TEMP}
	mkdir -p ${YCM_TEMP}
	@echo "***Building YouCompleteMe temp files***"
	@cd ${YCM_TEMP} && \
		cmake -G "Unix Makefiles" . ${VIM_PATH}/YouCompleteMe/third_party/ycmd/cpp && \
		cmake --build . --target ycm_core
	rm -rf ${YCM_TEMP}
endif
