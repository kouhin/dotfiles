;;; init-go-mode.el --- Init Go mode
;;; Commentary:
;; Required:
;; - gopls
;;; Code:

(when (depends 'go-mode)
  ;; config go-mode
  (with-eval-after-load 'go-mode
    )
  (add-hook 'go-mode-hook
    '(lambda()
       ;; load GOPATH
       (add-hook 'before-save-hook #'lsp-format-buffer t t)
       (add-hook 'before-save-hook #'lsp-organize-imports t t)
       (unless (getenv "GOPATH")
         (exec-path-from-shell-copy-env "GOPATH"))
       )))

(provide 'init-go-mode)
;;; init-go-mode.el ends here
