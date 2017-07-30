;;; init-typescript-mode.el --- Init typescript-mode
;;; Commentary:
;;; Code:

(require-package 'typescript-mode)
(require-package 'tide)

(add-hook 'typescript-mode-hook
          (lambda ()
            (tide-setup)
            (flycheck-mode +1)
            (defvar flycheck-check-syntax-automatically)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode +1)))
;; Tide can be used along with web-mode to edit tsx files
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (tide-setup)
              (flycheck-mode +1)
              (defvar flycheck-check-syntax-automatically)
              (setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode +1))))

(provide 'init-typescript-mode)

;;; init-typescript-mode.el ends here
