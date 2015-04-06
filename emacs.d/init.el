;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
	(error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list
 'load-path
     (expand-file-name "lisp" user-emacs-directory))

(require 'init-elpa)    ;; 加载ELPA，并定义了require-package函数
(require 'init-editing-utils)
(require 'init-utils)
(require 'init-web-mode)
(require 'init-markdown-mode)
(require 'init-yasnippet)
(require 'init-auto-complete)
(require 'init-go-mode)
(require 'init-flycheck)

(provide 'init)
