;;; init-helm.el --- Init helm

;;; Commentary:
;; Find text

;;; Code:
(use-package helm
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'helm-mode)
  (bind-key "M-x" 'helm-M-x)
  :config
  (require 'helm-config))

(use-package helm-ag
  :ensure t
  :defer t)
(use-package helm-descbinds
  :ensure t
  :defer t)

(provide 'init-helm)
;;; init-helm.el ends here
