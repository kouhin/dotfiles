;;; init-projectile.el --- Init projectile
;;; Commentary:
;; for project
;;; Code:
(require-package 'projectile)
(with-eval-after-load 'projectile
  (defvar projectile-completion-system)
  (setq projectile-completion-system 'helm))
(add-hook 'after-init-hook 'projectile-global-mode)

(require-package 'helm-projectile)
(add-hook 'helm-mode-hook 'helm-projectile-on)

(provide 'init-projectile)

;;; init-projectile.el ends here
