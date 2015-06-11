;;; init-helm.el --- Init helm

;;; Commentary:
;; Find text

;;; Code:
(use-package helm
  :ensure t
  :defer t
  :init
  (require 'helm-config)
  (bind-key "M-x" 'helm-M-x)
  (add-hook 'after-init-hook 'helm-mode))

(use-package helm-ag
  :ensure t
  :defer t)
(use-package helm-descbinds
  :ensure t
  :defer t)

(provide 'init-helm)
;;; init-helm.el ends here
