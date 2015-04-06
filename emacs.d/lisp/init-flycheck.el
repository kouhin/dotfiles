;;; init-flycheck --- Init flycheck

;;; Commentary:
;; check file syntax

;;; Code:

(require-package 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

(provide 'init-flycheck)

;;; init-flycheck.el ends here
