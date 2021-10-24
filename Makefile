link:
	ln -sf $(shell pwd)/vimrc $(HOME)/.vimrc
	ln -sf $(shell pwd)/vimrc.local $(HOME)/.vimrc.local
	ln -sf $(shell pwd)/vimrc.local.bundles $(HOME)/.vimrc.local.bundles
	ln -sf $(shell pwd)/zshenv $(HOME)/.zshenv
	ln -sf $(shell pwd)/zshrc $(HOME)/.zshrc
	ln -sf $(shell pwd)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(shell pwd)/emacs.d $(HOME)/.emacs.d
	ln -sf $(shell pwd)/hammerspoon $(HOME)/.hammerspoon
	ln -sf $(shell pwd)/Brewfile $(HOME)/.Brewfile
clean:
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.zshenv
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.tmux.conf
	unlink $(HOME)/.emacs.d
init-web:
	npm install eslint-cli -g
	npm install stylelint -g
init-rust:
	cargo install --git https://github.com/phildawes/racer.git
	cargo install --git https://github.com/rust-lang-nursery/rustfmt
