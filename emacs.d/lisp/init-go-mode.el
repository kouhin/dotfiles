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

(use-package go-mode
  :ensure t
  :defer t
  :config

  (add-hook 'before-save-hook 'gofmt-before-save)

  ;; go-imports
  (let ((goimports
		 (executable-find "goimports")))
	(when goimports
	  (setq gofmt-command goimports)))

  (use-package rename
	:commands (go-rename)
	:load-path (lambda ()
				 (unless (getenv "GOPATH")
				   (exec-path-from-shell-copy-env "GOPATH"))
				 (let ((gorename (executable-find "gorename")))
				   (when gorename
					 (list
					  (expand-file-name "../../src/golang.org/x/tools/refactor/rename" gorename))))))
  (use-package go-oracle
	:load-path (lambda ()
				 (unless (getenv "GOPATH")
				   (exec-path-from-shell-copy-env "GOPATH"))
				 (let ((oracle (executable-find "oracle")))
				   (when oracle
					 (list
					  (expand-file-name "../../src/golang.org/x/tools/cmd/oracle" oracle)))))
	:init
	(load "oracle"))

  ;; go-direx
  (use-package go-direx
	:ensure t
	:init
	(bind-key "C-c j" 'go-direx-pop-to-buffer go-mode-map)))

;; company-go
(use-package company-go
  :ensure t
  :defer t
  :init
  (add-hook 'go-mode-hook (lambda ()
							(defvar company-backends)
							(set (make-local-variable 'company-backends)
								 '((company-go)))))
  :config
  (setq company-go-show-annotation t)
  (setq company-go-insert-arguments nil))

;; go-test
(use-package gotest
  :ensure t
  :defer t)

;; go-eldoc
(use-package go-eldoc
  :ensure t
  :defer t
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

;; helm-go-package
(use-package helm-go-package
  :ensure t
  :defer t)

(provide 'init-go-mode)
;;; init-go-mode.el ends here
