;;; init-typescript-mode.el --- Init typescript-mode
;;; Commentary:
;;; Code:

(depends 'typescript-mode)
(depends 'add-node-modules-path)

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . typescript-mode))

(add-hook 'typescript-mode-hook (lambda () (add-node-modules-path) (if (executable-find "eslint") (progn (defun eslint-fix () "Where to display jscs-fix error output.  It can either be displayed in its own buffer, in the echo area, or not at all." (interactive) (message "eslint --fix the file %s" (buffer-file-name)) (shell-command (concat "eslint --fix " (buffer-file-name))) (revert-buffer t t))) (message "Please install eslint: 'npm install -g eslint-cli'.")) (if (projectile-project-p) (progn (when
                       (file-exists-p (expand-file-name ".prettierrc.json" (projectile-project-root)))
                     (prettier-js-mode))
                   ))
			(defvar flycheck-check-syntax-automatically)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode +1)
            (company-mode-on)))

(provide 'init-typescript-mode)

;;; init-typescript-mode.el ends here
