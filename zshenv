export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"
export GOPATH=$HOME/go
export PATH=$HOME/.cargo/bin:$GOPATH/bin:/usr/local/sbin:$PATH
export RUST_SRC_PATH=$HOME/git/rust/src
export JAVA_HOME=`/usr/libexec/java_home`
export MANPATH=/usr/local/man:$MANPATH
