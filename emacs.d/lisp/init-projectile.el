;;; init-projectile.el --- Init projectile
;;; Commentary:
;; for project
;;; Code:
(require-package 'projectile)
(require-package 'counsel-projectile)
(with-eval-after-load 'projectile
  (setq-default projectile-completion-system 'ivy)
  (setq-default projectile-switch-project-action 'projectile-dired)
  )

(add-hook 'after-init-hook 'projectile-global-mode)

(provide 'init-projectile)

;;; init-projectile.el ends here
