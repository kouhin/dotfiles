;;; init-core.el --- Core editor and UI settings -*- lexical-binding: t; -*-

;;; Commentary:
;; Built-in editing behavior, generated state, macOS environment, and theme.

;;; Code:

(declare-function ibuffer-switch-to-saved-filter-groups "ibuf-ext" (name))

(use-package emacs
  :ensure nil
  :init
  (setq-default indent-tabs-mode nil
                tab-width 2
                truncate-lines t
                truncate-partial-width-windows nil)
  (setq inhibit-startup-screen t
        initial-scratch-message nil
        read-process-output-max (* 1024 1024)
        ring-bell-function #'ignore
        scroll-conservatively 10000
        scroll-preserve-screen-position 'always
        set-mark-command-repeat-pop t
        use-short-answers t)
  (define-key local-function-key-map [?\C-¥] [?\C-\\])
  (define-key local-function-key-map [?\M-¥] [?\M-\\])
  (define-key local-function-key-map [?\C-\M-¥] [?\C-\M-\\])
  (when (eq system-type 'darwin)
    (setq ns-function-modifier 'hyper
          ns-option-modifier 'meta
          ns-command-modifier 'super)))

(use-package files
  :ensure nil
  :init
  (setq backup-directory-alist
        `(("." . ,(expand-file-name "backups/" kouhin/state-directory)))
        auto-save-file-name-transforms
        `((".*" ,(expand-file-name "auto-saves/" kouhin/state-directory) t))
        auto-save-list-file-prefix
        (expand-file-name "auto-save-list/.saves-" kouhin/state-directory)
        save-interprogram-paste-before-kill t
        vc-follow-symlinks t))

(use-package simple
  :ensure nil
  :init
  (column-number-mode 1)
  (line-number-mode 1)
  (global-auto-revert-mode 1)
  (global-prettify-symbols-mode 1)
  (show-paren-mode 1)
  (windmove-default-keybindings))

(use-package delsel
  :ensure nil
  :init
  (delete-selection-mode 1))

(use-package subword
  :ensure nil
  :hook (after-init . global-subword-mode))

(use-package mouse
  :ensure nil
  :if (not (display-graphic-p))
  :hook (after-init . xterm-mouse-mode))

(use-package prog-mode
  :ensure nil
  :hook (prog-mode . (lambda () (setq-local show-trailing-whitespace t))))

(use-package saveplace
  :ensure nil
  :custom
  (save-place-file (expand-file-name "places" kouhin/state-directory))
  :init
  (save-place-mode 1))

(use-package savehist
  :ensure nil
  :custom
  (savehist-file (expand-file-name "history" kouhin/state-directory))
  :init
  (savehist-mode 1))

(use-package recentf
  :ensure nil
  :custom
  (recentf-save-file (expand-file-name "recentf" kouhin/state-directory))
  (recentf-max-saved-items 200)
  :init
  (recentf-mode 1))

(use-package bookmark
  :ensure nil
  :custom
  (bookmark-default-file (expand-file-name "bookmarks" kouhin/state-directory)))

(use-package uniquify
  :ensure nil
  :custom
  (uniquify-buffer-name-style 'forward)
  (uniquify-separator "/")
  (uniquify-after-kill-buffer-p t)
  (uniquify-ignore-buffers-re "^\\*"))

(use-package dired
  :ensure nil
  :custom
  (dired-use-ls-dired (not (eq system-type 'darwin))))

(use-package ediff
  :ensure nil
  :custom
  (ediff-split-window-function #'split-window-horizontally)
  (ediff-window-setup-function #'ediff-setup-windows-plain))

(use-package ibuffer
  :ensure nil
  :functions ibuffer-switch-to-saved-filter-groups
  :bind ([remap list-buffers] . ibuffer-other-window)
  :custom
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-shrink-to-minimum-size t)
  (ibuffer-always-show-last-buffer nil)
  (ibuffer-sorting-mode 'recency)
  (ibuffer-use-header-line t)
  (ibuffer-saved-filter-groups
   '(("default"
      ("Magit" (name . "^\\*magit"))
      ("Emacs" (or (name . "^\\*scratch\\*$")
                    (name . "^\\*Messages\\*$")))
      ("Help" (or (name . "^\\*Help\\*$")
                  (name . "^\\*Apropos\\*$")
                  (name . "^\\*info\\*$"))))))
  :hook
  (ibuffer-mode . ibuffer-auto-mode)
  (ibuffer-mode . (lambda ()
                    (ibuffer-switch-to-saved-filter-groups "default")))
  :init
  (add-to-list 'display-buffer-alist
               '("\\*Ibuffer\\*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (window-height . 0.3)
                 (dedicated . t))))

(use-package editorconfig
  :ensure nil
  :config
  (editorconfig-mode 1))

(use-package exec-path-from-shell
  :if (and (eq system-type 'darwin)
           (or (daemonp) (display-graphic-p))
           (not (bound-and-true-p ns-emacs-plus-injected-path)))
  :custom
  (exec-path-from-shell-variables
   '("PATH" "MANPATH" "GOROOT" "GOPATH" "RUST_SRC_PATH"))
  :config
  (exec-path-from-shell-initialize))

(use-package comp-run
  :ensure nil
  :defer t
  :config
  (dolist (regexp '("/elpa/go-mode-[^/]+/go-mode\\.el\\'"
                    "/elpa/avy-[^/]+/avy\\.el\\'"
                    "/elpa/typescript-mode-[^/]+/typescript-mode\\.el\\'"))
    (add-to-list 'native-comp-jit-compilation-deny-list regexp)))

(use-package leuven-theme
  :if (display-graphic-p)
  :config
  (load-theme 'leuven t))

(provide 'init-core)
;;; init-core.el ends here
