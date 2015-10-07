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
(defvar show-paren-delay)
(setq show-paren-delay 0)

(setq-default left-fringe-width  10)
(setq-default right-fringe-width  0)
(set-face-attribute 'fringe nil :background "black")
(defvar linum-delay)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; yascroll
(require-package 'yascroll)
(add-hook 'after-init-hook 'global-yascroll-bar-mode)

;; delete-selection-mode
(delete-selection-mode)

(add-hook 'after-init-hook 'global-auto-revert-mode)

;; eldoc
(add-hook 'prog-mode-hook 'eldoc-mode)

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
(with-eval-after-load 'uniquify
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

(set-default 'imenu-auto-rescan t)

;; highlight-symbol
(require-package 'highlight-symbol)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
(add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)
(with-eval-after-load 'highlight-symbol
  (defvar highlight-symbol-idle-delay)
  (setq highlight-symbol-idle-delay 0.2))

;; undo tree
(require-package 'undo-tree)
(add-hook 'after-init-hook 'global-undo-tree-mode)

;; rainbow-delimiters
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; editorconfig
(require-package 'editorconfig)

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
							  ))

;; quickrun
(require-package 'quickrun)

;; copy & paste for OSX
(require-package 'pbcopy)
(turn-on-pbcopy)

(provide 'init-editing-utils)

;;; init-editing-utils.el ends here
