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
 tab-width 4
 make-backup-files t
 create-lockfiles nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t
 scroll-step 1
 scroll-conservatively 10000
 vc-follow-symlinks t)

(show-paren-mode t)
(setq show-paren-delay 0)

;; smooth-scroll
(use-package smooth-scroll
  :ensure t
  :commands (smooth-scroll-mode)
  :defer t
  :init
  (add-hook 'after-init-hook 'smooth-scroll-mode))

;; cua-mode
(cua-selection-mode t)

;; delete-selection-mode
(delete-selection-mode)

(global-auto-revert-mode t)

;; create auto-save file in ~/.emacs.d/backup

(defconst emacs-tmp-dir "~/.emacs.d/tmp/")
(unless (file-exists-p emacs-tmp-dir)
  (make-directory emacs-tmp-dir t))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
	  emacs-tmp-dir)

(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

;; meaningful names for buffers with the same name
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
  )

(set-default 'imenu-auto-rescan t)

;; highlight-symbol
(use-package highlight-symbol
  :ensure t
  :defer t
  :init
  (add-to-list 'prog-mode-hook 'highlight-symbol-mode)
  (add-to-list 'prog-mode-hook 'highlight-symbol-nav-mode)
  :config
  (setq highlight-symbol-idle-delay 0.2))

;; undo tree
(use-package undo-tree
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'global-undo-tree-mode))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; editorconfig
(use-package editorconfig
  :ensure t
  :defer t)

;; subword
(use-package syntax-subword
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'global-syntax-subword-mode))

(provide 'init-editing-utils)

;;; init-editing-utils.el ends here
