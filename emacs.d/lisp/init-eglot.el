;;; init-eglot.el --- Init Eglot
;;; Commentary:
;;; Code:

(depends 'eglot)
(depends 'kotlin-mode)

;(add-hook 'javascript-mode-hook 'eglot-ensure)
;(add-hook 'js-mode-hook 'eglot-ensure)
;(add-hook 'typescript-mode-hook 'eglot-ensure)

(add-hook 'css-mode-hook 'eglot-ensure)
(add-hook 'web-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'rust-mode-hook 'eglot-ensure)
(add-hook 'java-mode-hook 'eglot-ensure)
(add-hook 'kotlin-mode-hook 'eglot-ensure)

(setq read-process-output-max (* 1024 1024))
(setq eglot-stay-out-of '(flymake))

(add-hook 'eglot--managed-mode-hook (lambda () (add-hook 'flymake-diagnostic-functions 'eglot-flymake-backend nil t)))
(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "s-l a a") 'eglot-code-actions)
  (define-key eglot-mode-map (kbd "s-l a f") 'eglot-code-action-quickfix)
  (define-key eglot-mode-map (kbd "s-l r o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "s-l = =") 'eglot-format-buffer)
  (define-key eglot-mode-map (kbd "s-l = r") 'eglot-format)
  (define-key eglot-mode-map (kbd "s-l g d") 'eglot-find-declaration)
  (define-key eglot-mode-map (kbd "s-l g i") 'eglot-find-implementation)
  (define-key eglot-mode-map (kbd "s-l g t") 'eglot-find-typeDefinition))

(provide 'init-eglot)
;;; init-eglot.el ends here
