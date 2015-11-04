;;; init-flycheck --- Init flycheck
;;; Commentary:
;; check file syntax
;;; Code:

(require-package 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'html-tidy 'web-mode)
  (flycheck-add-mode 'css-csslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-jshint 'web-mode))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
