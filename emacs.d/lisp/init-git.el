;;; init-git.el --- Init Git

;;; Commentary:

;;; Code:

;; magit
(require-package 'magit)
(with-eval-after-load 'magit
  (defvar magit-last-seen-setup-instructions)
  (setq magit-last-seen-setup-instructions "1.4.0")
  (defvar magit-refresh-status-buffer)
  (setq magit-refresh-status-buffer nil))

;; disable build-in vc only for git
(setq vc-handled-backends (delq 'Git vc-handled-backends))

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
