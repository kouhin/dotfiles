;;; init-git.el --- Init Git

;;; Commentary:

;;; Code:

;; magit
(use-package magit
  :ensure t
  :defer t
  :config
  (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package magit-gitflow
  :ensure t
  :defer t
  :init
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

;; git-gutter
(use-package git-gutter
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'git-gutter-mode))

(use-package gitignore-mode
  :ensure t
  :defer t)
(use-package gitconfig-mode
  :ensure t
  :defer t)
(use-package gitattributes-mode
  :ensure t
  :defer t)
(use-package git-commit-mode
  :ensure t
  :defer t)
(use-package git-rebase-mode
  :ensure t
  :defer t)

(provide 'init-git)

;;; init-git.el ends here
