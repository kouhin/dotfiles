;;; init-editing-utils.el --- Init editor settings

;;; Commentary:
;; Some basic preferences

;;; Code:
(custom-set-variables '(blink-cursor-interval 0.4)
  '(bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory))
  '(case-fold-search t)
  '(column-number-mode t)
  '(line-number-mode t)
  '(delete-selection-mode t)
  '(ediff-split-window-function 'split-window-horizontally)
  '(ediff-window-setup-function 'ediff-setup-windows-plain)
  '(indent-tabs-mode nil)
  '(tab-width 2)
  '(make-backup-files t)
  '(create-lockfiles nil)
  '(mouse-yank-at-point t)
  '(save-interprogram-paste-before-kill t)
  '(scroll-preserve-screen-position 'always)
  '(set-mark-command-repeat-pop t)
  '(show-trailing-whitespace t)
  '(tooltip-delay 1.5)
  '(truncate-lines t)
  '(truncate-partial-width-windows nil)
  '(visible-bell t)
  '(scroll-step 1)
  '(scroll-conservatively 10000)
  '(vc-follow-symlinks t)
  '(js-switch-indent-offset 2)
  '(ad-redefinition-action 'accept)
  '(left-fringe-width  10)
  '(right-fringe-width  0)
  '(linum-delay t)
  '(uniquify-buffer-name-style 'forward)
  '(uniquify-separator "/")
  '(uniquify-after-kill-buffer-p t)
  '(uniquify-ignore-buffers-re "^\\*")
  '(imenu-auto-rescan t)
  '(dired-use-ls-dired nil))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode t)

(windmove-default-keybindings)

(set-face-attribute 'fringe nil
  :background "black")
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

;; symbol-overlay
(when (depends 'symbol-overlay)
  (add-hook 'prog-mode-hook 'symbol-overlay-mode)
  (with-eval-after-load 'symbol-overlay
    (defvar symbol-overlay-mode-map)
    (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
    (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev)))

;; undo tree
(when (depends 'undo-tree)
  (add-hook 'after-init-hook 'global-undo-tree-mode))

;; rainbow-delimiters
(when (depends 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; editorconfig
(when (depends 'editorconfig)
  (add-hook 'after-init-hook 'editorconfig-mode))

;; highlight-indentation
(when (depends 'highlight-indentation)
  (add-hook 'after-init-hook
    '(lambda ()
       (add-hook 'python-mode-hook 'highlight-indentation-mode)
       (add-hook 'coffee-mode-hook 'highlight-indentation-mode)
       (add-hook 'stylus-mode-hook 'highlight-indentation-mode)
       (add-hook 'jade-mode-hook 'highlight-indentation-mode)))
  (with-eval-after-load 'highlight-indentation (set-face-background 'highlight-indentation-face
                                                 "#4e4e4e")))

;; subword
(when (depends 'syntax-subword)
  (add-hook 'after-init-hook 'global-syntax-subword-mode))

;; expand region
(when (depends 'expand-region)
  (add-hook 'after-init-hook
    '(lambda()
       (global-set-key (kbd "C-=") 'er/expand-region)
       (global-set-key (kbd "M-'") 'er/expand-region))))

;; quickrun
(depends 'quickrun)

;; copy & paste for OSX
(when (depends 'osx-clipboard)
  (add-hook 'after-init-hook 'osx-clipboard-mode))

;; ag
(custom-set-variables '(ag-highlight-search t)
  '(ag-reuse-buffers 't))
(depends 'ag)

(when (depends 'mwim)
  (global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
  (global-set-key (kbd "C-e") 'mwim-end-of-code-or-line))

(when (depends 'flymake-diagnostic-at-point)
  (require 'flymake-diagnostic-at-point)
  (add-hook 'flymake-mode-hook 'flymake-diagnostic-at-point-mode))

(depends 'sudo-edit)

(depends 'elisp-format)

(provide 'init-editing-utils)

;;; init-editing-utils.el ends here
