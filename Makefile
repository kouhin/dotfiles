link:
	ln -sf $(shell pwd)/vimrc $(HOME)/.vimrc
	ln -sf $(shell pwd)/zshenv $(HOME)/.zshenv
	ln -sf $(shell pwd)/zshrc $(HOME)/.zshrc
	ln -sf $(shell pwd)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(shell pwd)/emacs.d $(HOME)/.emacs.d
	ln -sf $(shell pwd)/slate.js $(HOME)/.slate.js
clean:
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.zshenv
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.tmux.conf
	unlink $(HOME)/.emacs.d
	unlink $(HOME)/.slate.js
init-go:
	go get -u -v github.com/nsf/gocode
	go get -u -v github.com/rogpeppe/godef
	go get -u -v golang.org/x/tools/cmd/oracle
	go get -u -v golang.org/x/tools/cmd/gorename
	go get -u -v github.com/jstemmer/gotags
	go get -u -v github.com/alecthomas/gometalinter
	gometalinter -i
init-web:
	npm install eslint-cli -g
	npm install stylelint -g
	npm install tern -g
init-rust:
	cargo install --git https://github.com/phildawes/racer.git
	cargo install --git https://github.com/rust-lang-nursery/rustfmt
