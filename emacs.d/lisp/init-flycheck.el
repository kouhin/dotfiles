;;; init-flycheck --- Init flycheck

;;; Commentary:
;; check file syntax

;;; Code:

(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (add-hook 'flycheck-mode-hook (lambda()
								  (when (projectile-project-p)
									(unless (file-exists-p (expand-file-name ".jshintrc" (projectile-project-root)))
									  (flycheck-disable-checker 'javascript-jshint))
									(unless (file-exists-p (expand-file-name ".eslintrc" (projectile-project-root)))
									  (flycheck-disable-checker 'javascript-eslint))
									)
								  )))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
