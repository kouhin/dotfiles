link:
	ln -sf $(shell pwd)/vimrc $(HOME)/.vimrc
	ln -sf $(shell pwd)/zshrc $(HOME)/.zshrc
	ln -sf $(shell pwd)/bash_profile $(HOME)/.bash_profile
	ln -sf $(shell pwd)/tmux.conf $(HOME)/.tmux.conf
clean:
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.bash_profile
	unlink $(HOME)/.tmux.conf
