;;; init-git.el --- Init Git

;;; Commentary:

;;; Code:

;; magit
(require-package 'magit)
(with-eval-after-load 'magit
  (defvar magit-last-seen-setup-instructions)
  (setq magit-last-seen-setup-instructions "1.4.0"))

(require-package 'magit-gitflow)
(add-hook 'prog-mode-hook 'turn-on-magit-gitflow)

;; git-gutter
(require-package 'git-gutter)
(add-hook 'prog-mode-hook 'git-gutter-mode)

(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)
(require-package 'gitattributes-mode)

(provide 'init-git)

;;; init-git.el ends here
