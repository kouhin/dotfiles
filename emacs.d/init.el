;;; init.el --- bootstrap

;;; Commentary:
;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

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

(require 'init-elpa)
(require 'init-exec-path)
(require 'init-editing-utils)
(require 'init-ibuffer)
(require 'init-yasnippet)
(require 'init-company)
(require 'init-flycheck)

(require 'init-helm)
(require 'init-popwin)
(require 'init-projectile)
(require 'init-ace-mode)
(require 'init-speedbar)
(require 'init-git)
(require 'init-direx)
(require 'init-neotree)

;; Major modes
(require 'init-org-mode)
(require 'init-web-mode)
(require 'init-markdown-mode)
(require 'init-go-mode)
(require 'init-toml-mode)
(require 'init-yaml-mode)
(require 'init-dockerfile-mode)
(require 'init-rust-mode)
(require 'init-utils)

(load-theme 'tango-dark)

(provide 'init)

;;; init.el ends here
