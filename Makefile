link:
	ln -sf $(shell pwd)/vimrc $(HOME)/.vimrc
	ln -sf $(shell pwd)/zshrc $(HOME)/.zshrc
	ln -sf $(shell pwd)/bash_profile $(HOME)/.bash_profile
	ln -sf $(shell pwd)/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(shell pwd)/emacs.d $(HOME)/.emacs.d
	ln -sf $(shell pwd)/slate.js $(HOME)/.slate.js
clean:
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.zshrc
	unlink $(HOME)/.bash_profile
	unlink $(HOME)/.tmux.conf
	unlink $(HOME)/.emacs.d
	unlink $(HOME)/.slate.js
init-go:
	go get -u github.com/nsf/gocode
	go get -u golang.org/x/tools/cmd/goimports
	go get -u github.com/rogpeppe/godef
	go get -u golang.org/x/tools/cmd/oracle
	go get -u golang.org/x/tools/cmd/gorename
	go get -u github.com/golang/lint/golint
	go get -u github.com/kisielk/errcheck
	go get -u github.com/jstemmer/gotags
init-web:
	npm install babel -g
	npm install bower -g
	npm install coffee-script -g
	npm install coffeelint -g
	npm install eslint-cli -g
	npm install babel-eslint -g
	npm install csslint -g
	npm install gulp -g
	npm install jade -g
	npm install jsfmt -g
	npm install jshint -g
	npm install jsonlint -g
	npm install stylus -g
	npm install tern -g
	npm install phantomjs -g
	npm install gm -g
