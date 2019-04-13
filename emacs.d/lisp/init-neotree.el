;;; init-neotree.el --- initializes neotree-mode
;;; Commentary:
;;; Code:

(custom-set-variables
 '(projectile-switch-project-action 'neotree-projectile-action))
(when (depends 'neotree)
  (global-set-key [f8] 'neotree-toggle))
(provide 'init-neotree)

;;; init-neotree.el ends here
