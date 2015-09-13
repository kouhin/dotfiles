;;; init-neotree.el --- initializes neotree-mode
;;; Commentary:
;;; Code:

(require-package 'neotree)
(global-set-key [f8] 'neotree-toggle)
(with-eval-after-load "neotree"
  (defvar projectile-switch-project-action)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (defvar neo-persist-show)
  (when neo-persist-show
	(add-hook 'popwin:before-popup-hook
			  (lambda () (setq neo-persist-show nil)))
	(add-hook 'popwin:after-popup-hook
			  (lambda () (setq neo-persist-show t)))))
(provide 'init-neotree)

;;; init-neotree.el ends here
