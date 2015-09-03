;;; init-flycheck --- Init flycheck

;;; Commentary:
;; check file syntax

;;; Code:

(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode)
  :config
  (flycheck-add-mode 'html-tidy 'web-mode)
  (flycheck-add-mode 'css-csslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-jshint 'web-mode)
  (flycheck-add-mode 'javascript-jscs 'web-mode)
  )

(provide 'init-flycheck)

;;; init-flycheck.el ends here
