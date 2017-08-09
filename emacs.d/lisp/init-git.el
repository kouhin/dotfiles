;;; init-git.el --- Init Git

;;; Commentary:

;;; Code:

;; magit
(require-package 'magit)
(setq-default magit-push-current-set-remote-if-missing nil)
(with-eval-after-load 'magit
  (setq-default
   magit-refresh-status-buffer nil
   magit-fetch-arguments '("--prune")))

(require-package 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
(add-hook 'after-init-hook '(lambda()
                              (global-set-key (kbd "C-c C-g") 'magit-status)))

;; git-gutter
(require-package 'git-gutter)
(add-hook 'prog-mode-hook 'git-gutter-mode)

(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)
(require-package 'gitattributes-mode)

(provide 'init-git)

;;; init-git.el ends here
