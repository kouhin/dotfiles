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

(when (depends 'go-mode)
  (depends 'go-rename)
  (depends 'go-guru)
  (depends 'gotest)
  (depends 'go-eldoc)

  ;; config go-mode
  (with-eval-after-load 'go-mode
    ;; go-imports
    (let ((goimports
           (executable-find "goimports")))
      (when goimports
        (setq-default gofmt-command goimports))))

  (add-hook 'go-mode-hook '(lambda()
                             ;; load GOPATH
                             (unless (getenv "GOPATH")
                               (exec-path-from-shell-copy-env "GOPATH"))

                             ;; set eldoc
                             (go-eldoc-setup)

                             ;; gofmt
                             (add-hook 'before-save-hook 'gofmt-before-save))))

(provide 'init-go-mode)
;;; init-go-mode.el ends here
