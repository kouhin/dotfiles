link:
	ln -sf $(shell pwd)/vimrc $(HOME)/.vimrc
	ln -sf $(shell pwd)/zshrc $(HOME)/.zshrc
	ln -sf $(shell pwd)/bash_profile $(HOME)/.bash_profile
	ln -sf $(shell pwd)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(shell pwd)/emacs.d $(HOME)/.emacs.d
clean:
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.bash_profile
	unlink $(HOME)/.tmux.conf
	unlink $(HOME)/.emacs.d
