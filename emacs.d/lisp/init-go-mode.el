;;; init-go-mode.el --- Init Go mode

;;; Commentary:

;;; Code:

(require-package 'go-mode)
(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
                           (local-set-key (kbd "C-c C-g") 'go-goto-imports)
                           (local-set-key (kbd "C-c C-f") 'gofmt)
                           (local-set-key (kbd "C-c C-k") 'godoc)
						   (setq gofmt-command "goimports")
                           ))
(add-hook 'before-save-hook 'gofmt-before-save)

;;auto-complete
;;(require-package 'go-autocomplete)
;;(require 'go-autocomplete)

(require-package 'company-go)
(require 'company-go)

(add-hook 'go-mode-hook (lambda ()
						  (set (make-local-variable 'company-backends) '(company-go))
						                            (company-mode)))

;; eldoc
(require-package 'go-eldoc)
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; helm-go-package
(require-package 'helm-go-package)
(eval-after-load 'go-mode
    '(substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))

(provide 'init-go-mode)
;;; init-go-mode.el ends here
