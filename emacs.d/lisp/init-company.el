;;; init-company.el --- Init company-mode

;;; Commentary:
;; setting for company-mode

;;; Code:

(when (depends 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (with-eval-after-load 'company
    (defvar company-backends)
    (add-to-list 'company-backends 'company-yasnippet 'company-lsp)
    (defvar company-mode-map)
    (defvar company-active-map)
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-other-backend)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)

    (setq-default company-tooltip-limit 20
                  company-idle-delay 0.1
                  company-echo-delay 0
                  company-dabbrev-ignore-case nil
                  company-dabbrev-downcase nil
                  company-dabbrev-other-buffers 'all
                  company-tooltip-align-annotations t)
    (global-set-key (kbd "M-C-/") 'company-complete)))

(provide 'init-company)
;;; init-company.el ends here
