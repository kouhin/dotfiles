;;; init-javascript.el --- Init JavaScript Development Environment

;;; Commentary:

;; Required:
;; - node
;; - eslint

;;; Code:

(depends 'json-mode)
(depends 'vue-mode)
(depends 'js-doc)
(depends 'prettier-js)
(depends 'biomejs-format)
(depends 'flymake-eslint)
(require 'flymake-stylelint)

(custom-set-variables
  '(js-jsx-indent-level 2))
;; Fix js.el inndentation bug
(advice-add 'js--multi-line-declaration-indentation
  :override (lambda ()
              nil))

(when (depends 'typescript-mode)
  (define-derived-mode typescript-tsx-mode typescript-mode "typescript-tsx")
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-tsx-mode)))

(require 'derived)
(when (depends 'add-node-modules-path)
  (custom-set-variables '(add-node-modules-path-command "echo \"$(npm root)/.bin\""))
  (dolist (mode '(eglot-managed-mode typescript-mode js-mode coffee-mode))
    (add-hook (derived-mode-hook-name mode) '(lambda()
                                               (add-node-modules-path)))))

(defun kouhin/js-mode-hook ()
  (add-node-modules-path)
  (if (executable-find "eslint")
    (progn
      (defun eslint-fix ()
        "Where to display jscs-fix error output.  It can either be displayed in its own buffer, in the echo area, or not at all."
        (interactive)
        (message (concat (executable-find "eslint") " --fix " (buffer-file-name)))
        (shell-command (concat (executable-find "eslint") " --fix " (buffer-file-name)))
        (revert-buffer t t)))
    (message "Please install eslint: 'npm install -g eslint-cli'."))

  (if (projectile-project-p)
    (progn (when (file-exists-p (expand-file-name ".prettierrc.json" (projectile-project-root)))
             (prettier-js-mode))))
  (if (projectile-project-p)
    (progn (when (file-exists-p (expand-file-name "biome.json" (projectile-project-root)))
             (biomejs-format-mode))))
  (if (projectile-project-p)
    (progn (when (file-exists-p (expand-file-name ".eslintignore" (projectile-project-root)))
             (flymake-eslint-enable))))

  (local-set-key (kbd "M-.") nil)
  (eglot-ensure)
  (eldoc-mode +1)
  (add-to-list 'editorconfig-indentation-alist '(sgml-basic-offset))
  (editorconfig-apply))

(add-hook 'js-mode-hook 'kouhin/js-mode-hook)
(add-hook 'vue-mode-hook 'kouhin/js-mode-hook)
(add-hook 'typescript-mode-hook 'kouhin/js-mode-hook)

(add-hook 'css-mode-hook
  '(lambda()
     (add-node-modules-path)
     (if (projectile-project-p)
       (progn (when (file-exists-p (expand-file-name ".prettierrc.json" (projectile-project-root)))
                (prettier-js-mode))))))

(provide 'init-javascript)
;;; init-javascript.el ends here
