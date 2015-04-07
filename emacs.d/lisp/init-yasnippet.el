;;; init-yasnippet.el --- Init yasnippet

;;; Commentary:

;;; Code:

(require-package 'yasnippet)
(require 'yasnippet)
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))
(yas-global-mode t)

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
