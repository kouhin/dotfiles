;;; init-projectile.el --- Init projectile

;;; Commentary:
;; for project

;;; Code:

(el-get-bundle projectile
  (projectile-global-mode)
  (with-eval-after-load-feature 'helm-projectile
	(helm-projectile-on)))

(provide 'init-projectile)

;;; init-projectile.el ends here
