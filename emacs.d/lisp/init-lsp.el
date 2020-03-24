;;; init-lsp.el --- Init lsp mode
;;; Commentary:
;;; Code:

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

(depends 'lsp-mode)
(depends 'company-lsp)
(require 'flymake-eslint)
(require 'flymake-stylelint)

(add-hook 'javascript-mode-hook #'lsp)
(add-hook 'javascript-mode-hook #'flymake-eslint-enable)
(add-hook 'js-mode-hook #'lsp)
(add-hook 'js-mode-hook #'flymake-eslint-enable)

(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'flymake-eslint-enable)
(add-hook 'rjsx-mode-hook #'lsp)
(add-hook 'rjsx-mode-hook #'flymake-eslint-enable)
(add-hook 'js2-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'flymake-eslint-enable)

(add-hook 'css-mode-hook #'lsp)
(add-hook 'css-mode-hook #'flymake-stylelint-enable)

(add-hook 'web-mode-hook #'lsp)
(add-hook 'go-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'lsp)

(with-eval-after-load 'lsp-mode
  (setq lsp-diagnostic-package :flymake)
  (require 'lsp-clients))

(provide 'init-lsp)
;;; init-lsp.el ends here
