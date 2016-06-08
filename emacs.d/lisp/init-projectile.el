;;; init-projectile.el --- Init projectile
;;; Commentary:
;; for project
;;; Code:
(require-package 'projectile)
(with-eval-after-load 'projectile
  (defvar projectile-completion-system)
  (setq projectile-completion-system 'ivy))
(add-hook 'after-init-hook 'projectile-global-mode)

(provide 'init-projectile)

;;; init-projectile.el ends here
