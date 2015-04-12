;;; init-projectile.el --- Init projectile

;;; Commentary:
;; for project

;;; Code:

(require-package 'projectile)
(require 'projectile)

(projectile-global-mode)

(require-package 'helm-projectile)
(require 'helm-projectile)
(helm-projectile-on)

(provide 'init-projectile)

;;; init-projectile.el ends here
