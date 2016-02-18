;;; init-flycheck --- Init flycheck
;;; Commentary:
;; check file syntax
;;; Code:

(require-package 'flycheck)
(require-package 'flycheck-pos-tip)

(add-hook 'after-init-hook 'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'html-tidy 'web-mode)
  (flycheck-add-mode 'css-csslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-jshint 'web-mode)
  (flycheck-add-mode 'javascript-standard 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
  (flycheck-add-mode 'javascript-jshint 'js2-jsx-mode)
  (flycheck-add-mode 'javascript-standard 'js2-jsx-mode)
  (when (display-graphic-p)
	(flycheck-pos-tip-mode)))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
