;;; init-git.el --- Init Git

;;; Commentary:

;;; Code:

;; magit
(custom-set-variables '(magit-refresh-status-buffer nil))

(when (depends 'magit)
  (when (depends 'magit-gitflow)
    (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
    (add-hook 'after-init-hook
      '(lambda()
         (global-set-key (kbd "C-c C-g") 'magit-status)))))

;; git-gutter
(when (depends 'git-gutter)
  (add-hook 'prog-mode-hook 'git-gutter-mode))

(depends 'gitignore-mode)
(depends 'gitconfig-mode)
(depends 'gitattributes-mode)

(provide 'init-git)

;;; init-git.el ends here
