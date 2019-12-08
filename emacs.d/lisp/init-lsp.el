;;; init-lsp.el --- Init lsp mode
;;; Commentary:
;;; Code:

(depends 'lsp-mode)
(depends 'company-lsp)

                                        ; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'javascript-mode-hook #'lsp)
(add-hook 'js-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'rjsx-mode-hook #'lsp)
(add-hook 'css-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'lsp)
(add-hook 'web-mode-hook #'lsp)
(add-hook 'go-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)

(with-eval-after-load 'lsp-mode
  (require 'lsp-clients))

(provide 'init-lsp)
;;; init-lsp.el ends here
