;;; init-typescript-mode.el --- Init typescript-mode
;;; Commentary:
;;; Code:

(when (depends 'typescript-mode)
  (when (depends 'tide)

    (add-hook 'typescript-mode-hook
              (lambda ()
                (tide-setup)
                (setq-default flycheck-check-syntax-automatically '(save mode-enabled))))
    ;; Tide can be used along with web-mode to edit tsx files
    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
    (add-hook 'web-mode-hook
              (lambda ()
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (tide-setup)
                  (setq-default flycheck-check-syntax-automatically '(save mode-enabled)))))))

(provide 'init-typescript-mode)

;;; init-typescript-mode.el ends here
