;;; init-lsp.el --- Init lsp mode
;;; Commentary:
;;; Code:

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

(depends 'lsp-mode)
(depends 'dap-mode)
(depends 'lsp-java)
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
(add-hook 'go-mode-hook '(lambda()
                           (require 'dap-go)
                           ))
(add-hook 'rust-mode-hook #'lsp)
(add-hook 'java-mode-hook #'lsp)
(add-hook 'kotlin-mode-hook #'lsp)

(add-hook 'lsp-managed-mode-hook (lambda () (setq-local company-backends '(company-capf))))

(defvar flymake-no-changes-timeout)
(setq flymake-no-changes-timeout 2)

(setq dap-auto-configure-features '(sessions locals controls tooltip))
(with-eval-after-load 'lsp-mode
  (setq lsp-diagnostic-package :flymake))

(with-eval-after-load 'lsp-java
  (lsp-java-lombok))

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(provide 'init-lsp)
;;; init-lsp.el ends here
