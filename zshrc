# -*- mode: shell-script -*- #

if [[ ! -d ~/.zplug ]]; then
	git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh
zplug "zplug/zplug"

# Features
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# Theme
zplug "mafredri/zsh-async", defer:0
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Tools
zplug "rupa/z", use:z.sh
zplug "tj/n", as:command, use:bin/n

zplug check --verbose || zplug install
zplug load

# History
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_expand
setopt share_history

# Environment Variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export MANPATH=/usr/local/man:$MANPATH
export JAVA_HOME=`/usr/libexec/java_home`

# PATH
export PATH=/usr/local/sbin:$PATH
export GOPATH=$HOME/go; [[ :$PATH: == *":$GOPATH/bin:"* ]] || PATH+=":$GOPATH/bin"
export N_PREFIX=$HOME/n; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# Completion style
zstyle ':completion:*' menu select

# Alias
alias brewup='brew update && brew upgrade && brew cleanup'
alias e='emacs -nw'
alias ls='ls -G'
alias l='ls -al'
