# Makefile to install vim plugins
all: init_plugins update_plugins ycm

# submodule update all plugins!
init_plugins:
	git submodule init

# separate target in case we learn more about this process and want to add to it
update_plugins:
	git submodule update --init --recursive
