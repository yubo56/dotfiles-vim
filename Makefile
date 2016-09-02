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

ycm: ycm_make ycm_timeout

ycm_make:
ifndef CMAKE_PATH
	@echo 'cmake required' && exit 1
else
	rm -rf ${YCM_TEMP}
	mkdir -p ${YCM_TEMP}
	@echo "***Building YouCompleteMe temp files***"
	@cd ${YCM_TEMP} && \
		cmake -G "Unix Makefiles" . ${VIM_PATH}/YouCompleteMe/third_party/ycmd/cpp && \
		cmake --build . --target ycm_core
	rm -rf ${YCM_TEMP}
endif

ycm_timeout:
	@echo 'Setting timeout to 5 seconds'
	@# have to use backup then remove backup to be OS X compatible...
	@sed -i'.bak' 's/SECONDS\ =\ 0\.5/SECONDS\ =\ 5/g' ${VIM_PATH}/YouCompleteMe/python/ycm/client/completion_request.py
	@rm ${VIM_PATH}/YouCompleteMe/python/ycm/client/completion_request.py.bak

# Javascript semantic completion
ycm_js:
	cd ${VIM_PATH}/YouCompleteMe/third_party/ycmd/third_party/tern_runtime && npm install --production
