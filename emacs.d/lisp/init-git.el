;;; init-git.el --- Init Git

;;; Commentary:

;;; Code:

(require-package 'magit)
(require-package 'gitattributes-mode)
(require-package 'gitconfig-mode)
(require-package 'gitignore-mode)

(require 'magit)

(setq magit-last-seen-setup-instructions "1.4.0")

(require-package 'magit-gitflow)
(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

(provide 'init-git)

;;; init-git.el ends here
