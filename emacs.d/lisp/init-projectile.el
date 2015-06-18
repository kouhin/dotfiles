;;; init-projectile.el --- Init projectile

;;; Commentary:
;; for project

;;; Code:
(use-package projectile
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'helm-projectile-on))

(provide 'init-projectile)

;;; init-projectile.el ends here
