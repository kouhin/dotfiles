;;; init-completion.el --- Completion and navigation -*- lexical-binding: t; -*-

;;; Commentary:
;; Minibuffer completion, in-buffer completion, and structural navigation.

;;; Code:

(defvar dabbrev-ignored-buffer-modes)
(defvar dabbrev-ignored-buffer-regexps)

(use-package vertico
  :custom
  (vertico-cycle t)
  (vertico-count 15)
  :init
  (vertico-mode 1))

(use-package vertico-repeat
  :ensure nil
  :after vertico
  :bind ("<f6>" . vertico-repeat)
  :hook (minibuffer-setup . vertico-repeat-save))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package consult
  :bind
  (("C-s" . consult-line)
   ("C-c C-r" . consult-history)
   ("C-c g" . consult-git-grep)
   ("C-c j" . consult-ripgrep)
   ("C-c k" . consult-ripgrep)
   ("C-x l" . consult-locate)
   ([remap switch-to-buffer] . consult-buffer)
   ([remap yank-pop] . consult-yank-pop)))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  (corfu-popupinfo-delay '(1.0 . 0.5))
  :bind
  (:map corfu-map
        ("C-n" . corfu-next)
        ("C-p" . corfu-previous))
  :init
  (global-corfu-mode 1)
  :config
  (corfu-history-mode 1)
  (corfu-popupinfo-mode 1))

(use-package dabbrev
  :ensure nil
  :defines (dabbrev-ignored-buffer-modes dabbrev-ignored-buffer-regexps)
  :bind
  (("M-/" . dabbrev-completion)
   ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  (dolist (mode '(authinfo-mode doc-view-mode tags-table-mode))
    (add-to-list 'dabbrev-ignored-buffer-modes mode)))

(use-package avy
  :bind
  (("C-z" . avy-goto-char-2)
   ("C-c s ;" . avy-goto-char)
   ("C-c s e" . avy-goto-word-0)
   ("C-c s f" . avy-goto-line)
   ("C-c s w" . avy-goto-word-1)
   :map isearch-mode-map
   ("C-c ;" . avy-isearch))
  :config
  (avy-setup-default))

(use-package mwim
  :bind
  (("C-a" . mwim-beginning-of-code-or-line)
   ("C-e" . mwim-end-of-code-or-line)))

(use-package expand-region
  :bind
  (("C-=" . er/expand-region)
   ("M-'" . er/expand-region)))

(use-package symbol-overlay
  :hook (prog-mode . symbol-overlay-mode)
  :bind
  (:map symbol-overlay-mode-map
        ("M-n" . symbol-overlay-jump-next)
        ("M-p" . symbol-overlay-jump-prev)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'init-completion)
;;; init-completion.el ends here
