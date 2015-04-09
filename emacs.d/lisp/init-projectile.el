;;; init-projectile.el --- Init projectile

;;; Commentary:
;; for project

;;; Code:

(require-package 'projectile)
(require 'projectile)

(projectile-global-mode)

(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)

(require-package 'helm-projectile)
(require 'helm-projectile)
(helm-projectile-on)

(provide 'init-projectile)

;;; init-projectile.el ends here
