;;; init-flycheck --- Init flycheck

;;; Commentary:
;; check file syntax

;;; Code:

(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode))

  (provide 'init-flycheck)

;;; init-flycheck.el ends here
