;;; init.el --- bootstrap

;;; Commentary:
;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
	(error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

; Init package.el
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "https://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.org/packages/")
						 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(defun require-package (package &optional min-version no-refresh)
    "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
	(if (package-installed-p package min-version)
		t
	  (if (or (assoc package package-archive-contents) no-refresh)
		  (package-install package)
		(progn
		  (package-refresh-contents)
		          (require-package package min-version t)))))

; Install use-package
(require-package 'use-package)
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(defconst *spell-check-support-enabled* t) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))
(when *is-a-mac*
  (setq ns-function-modifier 'hyper)
  (setq ns-option-modifier 'meta)
  (setq ns-command-modifier 'super)
  (setq mac-function-modifier 'hyper)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super))

(add-to-list
 'load-path
 (expand-file-name "lisp" user-emacs-directory))

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
(require 'init-tabbar)

;; Major modes
(require 'init-web-mode)
(require 'init-markdown-mode)
(require 'init-go-mode)
(require 'init-toml-mode)
(require 'init-yaml-mode)
(require 'init-dockerfile-mode)

(use-package init-utils
  :commands (byte-compile-init-dir remove-elc-on-save)
  :init
  (add-hook 'emacs-lisp-mode-hook 'remove-elc-on-save))

(provide 'init)

;;; init.el ends here
