;;; init-yaml-mode --- Init Yaml mode
;;; Commentary:
;;; Code:

(use-package yaml-mode
  :ensure t
  :defer t
  :config
  (bind-key "C-m" 'newline-and-indent yaml-mode-map))

(provide 'init-yaml-mode)

;;; init-yaml-mode.el ends here
