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
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t)

(show-paren-mode t)
(setq show-paren-delay 0)

(cua-selection-mode t)

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

;; highlight-symbol
(require-package 'highlight-symbol)
(require 'highlight-symbol)
(add-to-list 'prog-mode-hook 'highlight-symbol-mode)
(add-to-list 'prog-mode-hook 'highlight-symbol-nav-mode)
(setq highlight-symbol-idle-delay 0.2)

;; undo tree
(require-package 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode)

(provide 'init-editing-utils)

;;; init-editing-utils.el ends here
