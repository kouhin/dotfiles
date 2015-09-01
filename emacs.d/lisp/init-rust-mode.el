;;; init-rust-mode.el --- Init rust
;;; Commentary:
;; Required:
;; - rust
;; - racer
;;; Code:

(use-package rust-mode
  :ensure t
  :defer t)

(use-package racer
  :ensure t
  :defer t
  :bind ("C-c C-j" . racer-find-definition)
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  :config
  (bind-key "TAB" 'company-indent-or-complete-common racer-mode-map))

(use-package flycheck-rust
  :ensure t
  :defer t
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(provide 'init-rust-mode)

;;; init-rust-mode.el ends here
