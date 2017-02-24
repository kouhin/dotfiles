;;; init-neotree.el --- initializes neotree-mode
;;; Commentary:
;;; Code:

(require-package 'neotree)
(global-set-key [f8] 'neotree-toggle)
(with-eval-after-load "neotree"
  (defvar projectile-switch-project-action)
  (setq projectile-switch-project-action 'neotree-projectile-action))
(provide 'init-neotree)

;;; init-neotree.el ends here
