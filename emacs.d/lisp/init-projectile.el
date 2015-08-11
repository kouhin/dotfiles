;;; init-projectile.el --- Init projectile

;;; Commentary:
;; for project

;;; Code:
(use-package projectile
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'projectile-global-mode)
  :config
  (setq projectile-completion-system 'helm))

(use-package helm-projectile
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'helm-projectile-on)
  :config
  (require 'grep))

(provide 'init-projectile)

;;; init-projectile.el ends here
