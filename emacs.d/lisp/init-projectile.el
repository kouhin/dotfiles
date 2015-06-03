;;; init-projectile.el --- Init projectile

;;; Commentary:
;; for project

;;; Code:

(el-get-bundle projectile
  (add-hook 'after-init-hook 'helm-projectile-on)
  (with-eval-after-load-feature 'projectile
	(projectile-global-mode)))

(provide 'init-projectile)

;;; init-projectile.el ends here
