;;; init-flycheck --- Init flycheck
;;; Commentary:
;; check file syntax
;;; Code:

(when (depends 'flycheck)
  (when (depends 'flycheck-pos-tip)

    (with-eval-after-load 'flycheck
      (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t)))

    (add-hook 'after-init-hook 'global-flycheck-mode)))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
