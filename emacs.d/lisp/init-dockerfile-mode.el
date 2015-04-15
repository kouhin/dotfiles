;;; init-dockerfile-mode.el --- Init dockerfile mode
;;; Commentary:
;;; Code:

(require-package 'dockerfile-mode)
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(provide 'init-dockerfile-mode)

;;; init-dockerfile-mode.el ends here
