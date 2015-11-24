export NVM_DIR="/usr/local/var/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export GOPATH=$HOME/go
export PATH=$HOME/.cargo/bin:$GOPATH/bin:/usr/local/sbin:$PATH
export RUST_SRC_PATH=$HOME/git/rust/src
export JAVA_HOME=`/usr/libexec/java_home`
