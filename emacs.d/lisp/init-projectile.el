;;; init-projectile.el --- Init projectile
;;; Commentary:
;; for project
;;; Code:
(when (depends 'projectile)
  (with-eval-after-load 'projectile (setq-default projectile-switch-project-action
                                      'projectile-dired)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    (when (depends 'projectile)
      (setq-default projectile-completion-system 'ivy))
    (when (depends 'counsel)
      (defun counsel-projectile-ag ()
        "Counsel version of projectile-ag."
        (interactive)
        (counsel-ag "" (projectile-project-root)))
      (defun counsel-projectile-rg ()
        "Counsel version of projectile-rg."
        (interactive)
        (counsel-rg "" (projectile-project-root)))
      (defvar projectile-mode-map)
      (let ((map (make-sparse-keymap)))
        (define-key projectile-mode-map [remap projectile-ag] 'counsel-projectile-ag)
        (define-key projectile-mode-map [remap projectile-ripgrep] 'counsel-projectile-rg))))
  (add-hook 'after-init-hook 'projectile-global-mode))

(provide 'init-projectile)

;;; init-projectile.el ends here
