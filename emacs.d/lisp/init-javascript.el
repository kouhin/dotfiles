;;; init-javascript.el --- Init JavaScript Development Environment

;;; Commentary:

;; Required:
;; - node
;; - eslint
;; - tern

;;; Code:

(depends 'json-mode)
(depends 'vue-mode)
(depends 'rjsx-mode)
(depends 'tern)
(depends 'js-doc)
(depends 'prettier-js)
(depends 'tide)
(depends 'add-node-modules-path)

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))

(setq-default js-indent-level 2)
;; Fix js.el inndentation bug
(advice-add 'js--multi-line-declaration-indentation :override (lambda () nil))

(if (executable-find "eslint")
    (progn
      (defun eslint-fix ()
        "Where to display jscs-fix error output.  It can either be displayed in its own buffer, in the echo area, or not at all."
        (interactive)
        (message "eslint --fix the file %s" (buffer-file-name))
        (shell-command (concat "eslint --fix " (buffer-file-name)))
        (revert-buffer t t)))
  (message "Please install eslint: 'npm install -g eslint-cli'."))

(with-eval-after-load 'rjsx-mode
  (setq-default
   js2-mode-show-parse-errors nil
   js2-mode-show-strict-warnings nil))

(add-hook 'rjsx-mode-hook
          '(lambda()
             (add-node-modules-path)
             (if (projectile-project-p)
                 (progn
                   (when
                       (file-exists-p (expand-file-name ".prettierrc.json" (projectile-project-root)))
                     (prettier-js-mode))
                   (when
                       (file-exists-p (expand-file-name "jsconfig.json" (projectile-project-root)))
                     (tide-setup)
                     (tide-hl-identifier-mode +1))
                   (when
                       (file-exists-p (expand-file-name ".tern-project" (projectile-project-root)))
                     (tern-mode))
                   ))
             (add-to-list 'editorconfig-indentation-alist '(rjsx-mode js2-basic-offset sgml-basic-offset))
             (editorconfig-apply)))
(add-hook 'js-mode-hook '(lambda()
                      (add-node-modules-path)
                      (prettier-js-mode)))
(add-hook 'vue-mode-hook '(lambda()
                       (add-node-modules-path)
                       (prettier-js-mode)))

(provide 'init-javascript)
;;; init-javascript.el ends here
