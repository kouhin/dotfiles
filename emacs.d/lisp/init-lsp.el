;;; init-lsp.el --- Init lsp mode
;;; Commentary:
;;; Code:

(depends 'lsp-mode)
(depends 'company-lsp)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'javascript-mode-hook #'lsp)
(add-hook 'rjsx-mode-hook #'lsp)
(add-hook 'css-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'lsp)
(add-hook 'web-mode-hook #'lsp)
(add-hook 'go-mode-hook #'lsp)

(with-eval-after-load 'lsp-mode
                      (require 'lsp-clients))

(when (depends 'lsp-ui)
  (with-eval-after-load 'lsp-ui
    (defvar lsp-ui-mode-map)
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
    (define-key lsp-ui-mode-map [remap js-find-symbol] #'lsp-ui-peek-find-definitions)))

(provide 'init-lsp)
;;; init-lsp.el ends here
