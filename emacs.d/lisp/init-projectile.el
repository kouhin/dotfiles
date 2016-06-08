;;; init-projectile.el --- Init projectile
;;; Commentary:
;; for project
;;; Code:
(require-package 'projectile)
(with-eval-after-load 'projectile
  (defvar projectile-completion-system)
  (setq projectile-completion-system 'ivy)
  (defvar projectile-switch-project-action)
  (setq projectile-switch-project-action 'projectile-dired)
  (defun counsel-projectile-ag ()
	"Counsel version of projectile-ag."
	(interactive)
	(counsel-ag "" (projectile-project-root)))
  (defvar projectile-mode-map)
  (define-key projectile-mode-map (kbd "C-c p s s") 'counsel-projectile-ag))

(add-hook 'after-init-hook 'projectile-global-mode)

(provide 'init-projectile)

;;; init-projectile.el ends here
