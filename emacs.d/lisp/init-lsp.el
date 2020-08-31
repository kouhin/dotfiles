;;; init-lsp.el --- Init lsp mode
;;; Commentary:
;;; Code:

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

(depends 'lsp-mode)
(depends 'lsp-java)
(depends 'company-lsp)
(depends 'kotlin-mode)
(require 'flymake-eslint)
(require 'flymake-stylelint)
(require 'lsp-java-lombok)

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
(add-hook 'java-mode-hook #'lsp)
(add-hook 'kotlin-mode-hook #'lsp)

(defvar flymake-no-changes-timeout)
(setq flymake-no-changes-timeout 2)

(with-eval-after-load 'lsp-mode
  (setq lsp-diagnostic-package :flymake))

(with-eval-after-load 'lsp-java
  (lsp-java-lombok))

(provide 'init-lsp)
;;; init-lsp.el ends here
