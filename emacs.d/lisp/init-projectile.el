;;; init-projectile.el --- Init projectile

;;; Commentary:
;; for project

;;; Code:

(el-get-bundle projectile
  (add-hook 'prog-mode-hook 'projectile-mode))

(provide 'init-projectile)

;;; init-projectile.el ends here
