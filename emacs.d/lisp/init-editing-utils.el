;;; init-editing-utils.el --- Init editor settings

;;; Commentary:
;; Some basic preferences

;;; Code:
(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 case-fold-search t
 column-number-mode t
 line-number-mode t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil
 tab-width 2
 make-backup-files t
 create-lockfiles nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines t
 truncate-partial-width-windows nil
 visible-bell t
 scroll-step 1
 scroll-conservatively 10000
 vc-follow-symlinks t
 js-switch-indent-offset 2
 ad-redefinition-action 'accept)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode t)

(windmove-default-keybindings)

(setq-default left-fringe-width  10)
(setq-default right-fringe-width  0)
(set-face-attribute 'fringe nil :background "black")
(setq-default linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; newline
(global-set-key (kbd "RET") 'newline-and-indent)

;; mouse
(global-set-key [mouse-4] 'scroll-down-line)
(global-set-key [mouse-5] 'scroll-up-line)
(add-hook 'after-init-hook 'xterm-mouse-mode)

;; delete-selection-mode
(delete-selection-mode)

(add-hook 'after-init-hook 'global-auto-revert-mode)

;; eldoc
(add-hook 'prog-mode-hook 'eldoc-mode)

(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

;; meaningful names for buffers with the same name
(with-eval-after-load 'uniquify
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

(set-default 'imenu-auto-rescan t)

;; symbol-overlay
(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook 'symbol-overlay-mode)
(with-eval-after-load 'symbol-overlay
  (defvar symbol-overlay-mode-map)
  (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev))

;; undo tree
(require-package 'undo-tree)
(add-hook 'after-init-hook 'global-undo-tree-mode)

;; rainbow-delimiters
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; editorconfig
(require-package 'editorconfig)
(add-hook 'after-init-hook 'editorconfig-mode)

;; highlight-indentation
(require-package 'highlight-indentation)
(add-hook 'after-init-hook '(lambda ()
                              (add-hook 'python-mode-hook 'highlight-indentation-mode)
                              (add-hook 'coffee-mode-hook 'highlight-indentation-mode)
                              (add-hook 'stylus-mode-hook 'highlight-indentation-mode)
                              (add-hook 'jade-mode-hook 'highlight-indentation-mode)
                              ))
(with-eval-after-load 'highlight-indentation
  (set-face-background 'highlight-indentation-face "#4e4e4e"))

;; subword
(require-package 'syntax-subword)
(add-hook 'after-init-hook 'global-syntax-subword-mode)

;; expand region
(require-package 'expand-region)
(add-hook 'after-init-hook '(lambda()
                              (global-set-key (kbd "C-=") 'er/expand-region)
                              (global-set-key (kbd "M-'") 'er/expand-region)
                              ))

;; quickrun
(require-package 'quickrun)

;; copy & paste for OSX
(require-package 'osx-clipboard)
(add-hook 'after-init-hook 'osx-clipboard-mode)

;; ag
(require-package 'ag)
(with-eval-after-load 'ag
  (setq-default ag-highlight-search t)
  (setq-default ag-reuse-buffers 't))

(setq-default dired-use-ls-dired nil)

(require-package 'mwim)
(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

(require-package 'sudo-edit)

(provide 'init-editing-utils)

;;; init-editing-utils.el ends here
