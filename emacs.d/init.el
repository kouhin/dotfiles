;;; init.el --- bootstrap

;;; Commentary:
;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq gc-cons-threshold (* 128 1024 1024))

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
	(error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(setq user-emacs-directory "~/.emacs.d")

(add-to-list
 'load-path
 (expand-file-name "lisp" user-emacs-directory))

(defconst *spell-check-support-enabled* t) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))
(when *is-a-mac*
  (setq ns-function-modifier 'hyper)
  (setq ns-option-modifier 'meta)
  (setq ns-command-modifier 'super)
  (setq mac-function-modifier 'hyper)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super))

(setq ring-bell-function 'ignore)

;;set all coding systems to utf-8
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'init-elpa)
(require 'init-exec-path)
(require 'init-term)
(require 'init-editing-utils)
(require 'init-ibuffer)
(require 'init-yasnippet)
(require 'init-company)
(require 'init-flycheck)

(require 'init-ivy)
(require 'init-popwin)
(require 'init-projectile)
(require 'init-avy-mode)
(require 'init-speedbar)
(require 'init-git)
(require 'init-neotree)

;; Major modes
(require 'init-org-mode)
(require 'init-web-mode)
(require 'init-typescript-mode)
(require 'init-markdown-mode)
(require 'init-go-mode)
(require 'init-toml-mode)
(require 'init-yaml-mode)
(require 'init-dockerfile-mode)
(require 'init-rust-mode)
(require 'init-utils)

(when (display-graphic-p)
  (load-theme 'deeper-blue))

(provide 'init)

;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(flycheck-rust rustfmt cargo racer rust-mode dockerfile-mode yaml-mode toml-mode go-eldoc gotest company-go go-mode gh-md markdown-mode tide typescript-mode js-doc skewer-mode company-tern company-web stylus-mode jade-mode sws-mode coffee-mode jsfmt json-mode js2-refactor yasnippet xterm-color web-mode undo-tree syntax-subword sr-speedbar rainbow-delimiters quickrun projectile-speedbar popwin osx-clipboard neotree mwim magit-gitflow js2-mode highlight-symbol highlight-indentation gitignore-mode gitconfig-mode gitattributes-mode git-gutter flycheck-pos-tip expand-region exec-path-from-shell editorconfig counsel company-quickhelp avy anzu ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white")))))
