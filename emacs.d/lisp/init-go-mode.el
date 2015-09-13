;;; init-go-mode.el --- Init Go mode
;;; Commentary:
;; Required:
;; - go
;; - go-rename
;; - go-oracle
;; - gocode
;; - goimports
;; - golint
;; - errcheck
;;; Code:

(require-package 'go-mode)
(require-package 'company-go)
(require-package 'gotest)
(require-package 'go-eldoc)
(require-package 'helm-go-package)

;; config company-go
(with-eval-after-load 'company-go
  (defvar company-go-show-annotation)
  (defvar company-go-insert-arguments)
  (setq company-go-show-annotation t)
  (setq company-go-insert-arguments nil))

;; config go-mode
(with-eval-after-load 'go-mode
  ;; go-imports
  (let ((goimports
		 (executable-find "goimports")))
	(when goimports
	  (defvar gofmt-command)
	  (setq gofmt-command goimports)))
  ;; load go-rename
  (let ((gorename (executable-find "gorename")))
	(when gorename
	  (add-to-list 'load-path
				   (expand-file-name "../../src/golang.org/x/tools/refactor/rename" gorename))
	  (load "rename")))

  ;; load go-oracle
  (let ((oracle (executable-find "oracle")))
	(when oracle
	  (add-to-list 'load-path
				   (expand-file-name "../../src/golang.org/x/tools/cmd/oracle" oracle))
	  (load "oracle"))))

(add-hook 'go-mode-hook '(lambda()
						   ;; load GOPATH
						   (unless (getenv "GOPATH")
							 (exec-path-from-shell-copy-env "GOPATH"))

						   ;; set eldoc
						   (go-eldoc-setup)

						   ;; gofmt
						   (add-hook 'before-save-hook 'gofmt-before-save)

						   ;; init company-go
						   (defvar company-backends)
						   (set (make-local-variable 'company-backends)
								'((company-go)))))

(provide 'init-go-mode)
;;; init-go-mode.el ends here
