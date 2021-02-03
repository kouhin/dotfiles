;;; init-eglot.el --- Init Eglot
;;; Commentary:
;;; Code:

(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

(depends 'eglot)
(depends 'kotlin-mode)
(require 'flymake-eslint)
(require 'flymake-stylelint)

(add-hook 'javascript-mode-hook #'eglot-ensure)
(add-hook 'javascript-mode-hook #'flymake-eslint-enable)
(add-hook 'js-mode-hook #'eglot-ensure)
(add-hook 'js-mode-hook #'flymake-eslint-enable)

(add-hook 'typescript-mode-hook #'eglot-ensure)
(add-hook 'typescript-mode-hook #'flymake-eslint-enable)
(add-hook 'rjsx-mode-hook #'eglot-ensure)
(add-hook 'rjsx-mode-hook #'flymake-eslint-enable)
(add-hook 'js2-mode-hook #'eglot-ensure)
(add-hook 'js2-mode-hook #'flymake-eslint-enable)

(add-hook 'css-mode-hook #'eglot-ensure)
(add-hook 'css-mode-hook #'flymake-stylelint-enable)

(add-hook 'web-mode-hook #'eglot-ensure)
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'rust-mode-hook #'eglot-ensure)
(add-hook 'java-mode-hook #'eglot-ensure)
(add-hook 'kotlin-mode-hook #'eglot-ensure)

(defvar flymake-no-changes-timeout)
(setq flymake-no-changes-timeout 2)

(provide 'init-eglot)
;;; init-eglot.el ends here
