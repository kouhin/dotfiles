;;; init.el --- bootstrap

;;; Commentary:
;; This file bootstraps the configuration, which is divided into
;; a number of other files.


;;; Code:

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer      (url-retrieve-synchronously
							 "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
	(goto-char (point-max))
	(eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get-bundle with-eval-after-load-feature)

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

(add-to-list
 'load-path
     (expand-file-name "lisp" user-emacs-directory))

;(require 'init-utils)
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

(provide 'init)

;;; init.el ends here
