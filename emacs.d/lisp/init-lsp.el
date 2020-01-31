;;; init-lsp.el --- Init lsp mode
;;; Commentary:
;;; Code:

(depends 'lsp-mode)
(depends 'lsp-ui)
(depends 'company-lsp)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'javascript-mode-hook
  '(lambda()
     (lsp-deferred)
     (with-eval-after-load 'lsp-ui (flycheck-add-next-checker 'lsp-ui 'javascript-eslint))))
(add-hook 'js-mode-hook
  '(lambda()
     (lsp-deferred)
     (with-eval-after-load 'lsp-ui (flycheck-add-next-checker 'lsp-ui 'javascript-eslint))))
(add-hook 'typescript-mode-hook
  '(lambda()
     (lsp-deferred)
     (with-eval-after-load 'lsp-ui (flycheck-add-next-checker 'lsp-ui 'javascript-eslint))))
(add-hook 'rjsx-mode-hook
  '(lambda()
     (lsp-deferred)
     (with-eval-after-load 'lsp-ui (flycheck-add-next-checker 'lsp-ui 'javascript-eslint))))
(add-hook 'js2-mode-hook '(lambda()
     (lsp-deferred)
     (with-eval-after-load 'lsp-ui (flycheck-add-next-checker 'lsp-ui 'javascript-eslint))))
(add-hook 'css-mode-hook #'lsp)
(add-hook 'web-mode-hook #'lsp)
(add-hook 'go-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)


(with-eval-after-load 'lsp-mode
  (require 'lsp-clients)
  (setq-default lsp-prefer-flymake nil))

(provide 'init-lsp)
;;; init-lsp.el ends here
