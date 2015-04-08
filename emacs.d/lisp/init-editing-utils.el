;;; init-editing-utils.el --- Init editor settings

;;; Commentary:
;; Some basic preferences

;;; Code:

(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil
 tab-width 4
 make-backup-files nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t)

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

(provide 'init-editing-utils)

;;; init-editing-utils.el ends here
