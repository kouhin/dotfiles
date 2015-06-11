;;; init-speedbar.el --- Init speedbar
;;; Commentary:
;;; Code:

(use-package sr-speedbar
  :ensure t
  :defer t
  :config
  (setq sr-speedbar-default-width 5)
  (setq sr-speedbar-max-width 5)
  (setq sr-speedbar-auto-refresh t))

(use-package projectile-speedbar
  :ensure t
  :defer t)

(use-package speedbar
  :defer t
  :config
  (setq speedbar-show-unknown-files t)
  (setq speedbar-smart-directory-expand-flag t)
  (setq speedbar-use-images nil))



(provide 'init-speedbar)

;;; init-speedbar.el ends here
