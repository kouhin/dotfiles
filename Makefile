DOTFILES_DIR := $(CURDIR)

.PHONY: link clean

define link_dotfile
	@if [ ! -e "$(1)" ] && [ ! -L "$(1)" ]; then \
		echo "error: source $(1) does not exist" >&2; \
		exit 1; \
	elif [ -L "$(2)" ]; then \
		rm -f "$(2)"; \
		ln -s "$(1)" "$(2)"; \
	elif [ -e "$(2)" ]; then \
		echo "error: $(2) already exists and is not a symlink" >&2; \
		exit 1; \
	else \
		ln -s "$(1)" "$(2)"; \
	fi
endef

define clean_dotfile
	@if [ -L "$(1)" ]; then \
		rm -f "$(1)"; \
	elif [ -e "$(1)" ]; then \
		echo "skip: $(1) exists and is not a symlink" >&2; \
	fi
endef

link:
	$(call link_dotfile,$(DOTFILES_DIR)/vimrc,$(HOME)/.vimrc)
	$(call link_dotfile,$(DOTFILES_DIR)/vimrc.local,$(HOME)/.vimrc.local)
	$(call link_dotfile,$(DOTFILES_DIR)/vimrc.local.bundles,$(HOME)/.vimrc.local.bundles)
	$(call link_dotfile,$(DOTFILES_DIR)/zshrc,$(HOME)/.zshrc)
	$(call link_dotfile,$(DOTFILES_DIR)/tmux.conf,$(HOME)/.tmux.conf)
	$(call link_dotfile,$(DOTFILES_DIR)/emacs.d,$(HOME)/.emacs.d)
	$(call link_dotfile,$(DOTFILES_DIR)/hammerspoon,$(HOME)/.hammerspoon)
	$(call link_dotfile,$(DOTFILES_DIR)/Brewfile,$(HOME)/.Brewfile)
	mkdir -p "$(HOME)/.config/sheldon"
	$(call link_dotfile,$(DOTFILES_DIR)/sheldon/plugins.toml,$(HOME)/.config/sheldon/plugins.toml)
	mkdir -p "$(HOME)/.config/mise"
	$(call link_dotfile,$(DOTFILES_DIR)/mise/config.toml,$(HOME)/.config/mise/config.toml)

clean:
	$(call clean_dotfile,$(HOME)/.vimrc)
	$(call clean_dotfile,$(HOME)/.vimrc.local)
	$(call clean_dotfile,$(HOME)/.vimrc.local.bundles)
	$(call clean_dotfile,$(HOME)/.zshenv)
	$(call clean_dotfile,$(HOME)/.zshrc)
	$(call clean_dotfile,$(HOME)/.tmux.conf)
	$(call clean_dotfile,$(HOME)/.emacs.d)
	$(call clean_dotfile,$(HOME)/.hammerspoon)
	$(call clean_dotfile,$(HOME)/.Brewfile)
	$(call clean_dotfile,$(HOME)/.config/sheldon/plugins.toml)
	$(call clean_dotfile,$(HOME)/.config/mise/config.toml)
	@rmdir "$(HOME)/.config/sheldon" 2>/dev/null || true
	@rmdir "$(HOME)/.config/mise" 2>/dev/null || true
