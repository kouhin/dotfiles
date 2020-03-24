;;; init-flycheck --- Init flycheck
;;; Commentary:
;; check file syntax
;;; Code:

(when (depends 'flycheck)
  (when (depends 'flycheck-pos-tip)
    (with-eval-after-load 'flycheck (advice-add 'flycheck-eslint-config-exists-p
                                      :override (lambda() t))
      (flycheck-add-mode 'javascript-eslint 'vue-mode)
      (flycheck-add-mode 'javascript-eslint 'vue-html-mode)
      (flycheck-add-mode 'javascript-eslint 'css-mode))
    ;(add-hook 'after-init-hook 'global-flycheck-mode)
    ))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
