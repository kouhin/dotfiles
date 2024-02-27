;;; init-company.el --- Init company-mode

;;; Commentary:
;; setting for company-mode

;;; Code:
(add-hook 'after-init-hook 'global-company-mode)

(custom-set-variables '(company-tooltip-limit 20)
  '(company-idle-delay 0.1)
  '(company-echo-delay 0)
  '(company-dabbrev-ignore-case nil)
  '(company-dabbrev-downcase nil)
  '(company-dabbrev-other-buffers 'all)
  '(company-tooltip-align-annotations t))

(add-hook 'company-mode-hook 'company-box-mode)

(depends 'company-box)
(when (depends 'company)
  (with-eval-after-load 'company
    (defvar company-backends)
    (add-to-list 'company-backends 'company-yasnippet)
    (defvar company-mode-map)
    (defvar company-active-map)
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-other-backend)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (global-set-key (kbd "M-C-/") 'company-complete)))

(with-eval-after-load 'copilot
  (custom-set-variables '(copilot-indent-offset-warning-disable 1))
  (when (copilot-installed-version)
    (add-hook 'company-mode-hook 'copilot-mode)
    (define-key copilot-mode-map (kbd "s-<return>") 'copilot-accept-completion)))

(provide 'init-company)
;;; init-company.el ends here
