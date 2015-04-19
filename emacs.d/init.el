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

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

(add-to-list
 'load-path
     (expand-file-name "lisp" user-emacs-directory))

(require 'init-elpa)
(require 'init-utils)
(require 'init-exec-path)
(require 'init-editing-utils)
(require 'init-yasnippet)
(require 'init-company)
(require 'init-flycheck)

(require 'init-helm)
(require 'init-projectile)
(require 'init-sws-mode)
(require 'init-ace-mode)
(require 'init-speedbar)
(require 'init-git)
(require 'init-direx)

(require 'init-web-mode)
(require 'init-markdown-mode)
(require 'init-go-mode)

(provide 'init)

;;; init.el ends here
