;;; init-javascript.el --- Init JavaScript Development Environment

;;; Commentary:

;; Required:
;; - node
;; - eslint

;;; Code:

(depends 'json-mode)
(depends 'vue-mode)
(depends 'rjsx-mode)
(depends 'js-doc)
(depends 'prettier-js)
(depends 'add-node-modules-path)

(custom-set-variables
  '(js-jsx-indent-level 2)
  '(js2-mode-show-parse-errors nil)
  '(js2-mode-show-strict-warnings nil))
;; Fix js.el inndentation bug
(advice-add 'js--multi-line-declaration-indentation
  :override (lambda ()
              nil))

(add-hook 'css-mode-hook
  '(lambda()
     (add-node-modules-path)
     (if (projectile-project-p)
       (progn (when (file-exists-p (expand-file-name ".prettierrc.json" (projectile-project-root)))
                (prettier-js-mode))))))

(add-hook 'js-mode-hook
  '(lambda()
     (add-node-modules-path)
     (define-key js-mode-map (kbd "M-.") nil)))
(add-hook 'rjsx-mode-hook
  '(lambda()
     (add-node-modules-path)
     (if (projectile-project-p)
       (progn (when (file-exists-p (expand-file-name ".prettierrc.json" (projectile-project-root)))
                (prettier-js-mode))))
     (add-to-list 'editorconfig-indentation-alist '(js2-basic-offset sgml-basic-offset))
     (editorconfig-apply)))
(add-hook 'js-mode-hook
  '(lambda()
     (add-node-modules-path)
     (if (executable-find "eslint")
       (progn
         (defun eslint-fix ()
           "Where to display jscs-fix error output.  It can either be displayed in its own buffer, in the echo area, or not at all."
           (interactive)
           (message "eslint --fix the file %s" (buffer-file-name))
           (shell-command (concat "eslint --fix " (buffer-file-name)))
           (revert-buffer t t)))
       (message "Please install eslint: 'npm install -g eslint-cli'."))
     (prettier-js-mode)))
(add-hook 'vue-mode-hook
  '(lambda()
     (add-node-modules-path)
     (prettier-js-mode)))

(provide 'init-javascript)
;;; init-javascript.el ends here
