# -*- mode: shell-script -*- #

# ─── Shell Options ────────────────────────────────────────────────
setopt AUTO_CD

# ─── History ──────────────────────────────────────────────────────
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups hist_expand share_history

# ─── Environment ──────────────────────────────────────────────────
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
export MANPATH="/usr/local/man:${MANPATH}"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

# ─── PATH ─────────────────────────────────────────────────────────
typeset -U path

export GOENV_ROOT="$HOME/.goenv"
export PNPM_HOME="$HOME/Library/pnpm"
export BUN_INSTALL="$HOME/.bun"

path=(
  $HOME/.bin
  $HOME/.local/bin
  $HOME/.rd/bin
  $HOME/.cargo/bin
  $GOENV_ROOT/bin
  $PNPM_HOME
  $BUN_INSTALL/bin
  /usr/local/sbin
  $path
)

# ─── Bootstrap (first-run only) ──────────────────────────────────
if ! (( $+commands[sheldon] )); then
  curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
fi

if [[ ! -e ~/.config/sheldon/plugins.toml ]]; then
  mkdir -p ~/.config/sheldon
  ln -sf "${${(%):-%x}:A:h}/sheldon/plugins.toml" ~/.config/sheldon/plugins.toml
fi

if [[ ! -e ~/.config/starship.toml ]]; then
  mkdir -p ~/.config
  curl -fsSL -o ~/.config/starship.toml https://starship.rs/presets/toml/pure-preset.toml
fi

[[ ! -d $HOME/.tmux/plugins/tpm ]] && \
  git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ─── Plugins ──────────────────────────────────────────────────────
eval "$(sheldon source)"

# ─── Tool Initialization ─────────────────────────────────────────
# Eager, not deferred — GUI apps (Fork, VS Code, etc.) spawn
# non-interactive shells where zsh-defer hooks never fire.
if (( $+commands[goenv] )); then
  eval "$(goenv init -)"
  path=($GOROOT/bin $path $GOPATH/bin)
fi

if [[ -x /usr/libexec/java_home ]] && /usr/libexec/java_home -v 21 &>/dev/null; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
  path=($JAVA_HOME/bin $path)
fi

(( $+commands[fnm] ))      && eval "$(fnm env --use-on-cd)"
(( $+commands[rbenv] ))     && eval "$(rbenv init - zsh)"
(( $+commands[luarocks] ))  && eval "$(luarocks path --bin)"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# ─── Aliases ──────────────────────────────────────────────────────
alias ddup='sheldon lock --update && brew bundle --global --cleanup'
alias e='emacs -nw'
alias ls='ls -G'
alias l='ls -al'

# ─── Prompt ───────────────────────────────────────────────────────
eval "$(starship init zsh)"
