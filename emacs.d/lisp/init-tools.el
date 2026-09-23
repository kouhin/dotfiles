;;; init-tools.el --- Projects, version control, and utilities -*- lexical-binding: t; -*-

;;; Commentary:
;; Project navigation, Git integration, and on-demand utility commands.

;;; Code:

(use-package project
  :ensure nil
  :bind-keymap ("C-c p" . project-prefix-map)
  :custom
  (project-list-file (expand-file-name "projects.eld" kouhin/state-directory))
  (project-switch-commands 'project-dired))

(use-package transient
  :defer t
  :custom
  (transient-history-file
   (expand-file-name "transient/history.el" kouhin/state-directory))
  (transient-levels-file
   (expand-file-name "transient/levels.el" kouhin/state-directory))
  (transient-values-file
   (expand-file-name "transient/values.el" kouhin/state-directory)))

(use-package magit
  :bind ("C-c C-g" . magit-status)
  :config
  (put 'magit-clean 'disabled nil))

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode))

(use-package git-modes
  :defer t)

(use-package quickrun
  :commands quickrun)

(use-package sudo-edit
  :commands sudo-edit)

(use-package elisp-format
  :commands (elisp-format-buffer elisp-format-region))

(provide 'init-tools)
;;; init-tools.el ends here
