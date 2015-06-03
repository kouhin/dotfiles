;;; init-flycheck --- Init flycheck

;;; Commentary:
;; check file syntax

;;; Code:

(el-get-bundle flycheck
  (add-hook 'after-init-hook 'global-flycheck-mode))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
