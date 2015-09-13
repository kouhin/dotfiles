;;; init-yaml-mode --- Init Yaml mode
;;; Commentary:
;;; Code:

(require-package 'yaml-mode)
(add-hook 'yaml-mode-hook '(lambda()
		  (defvar yaml-mode-map)
		  (define-key yaml-mode-map (kbd "C-m") 'newline-and-indent)))



(provide 'init-yaml-mode)

;;; init-yaml-mode.el ends here
