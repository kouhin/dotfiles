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
  (add-hook 'racer-mode-hook #'eldoc-mode))

(provide 'init-rust-mode)

;;; init-rust-mode.el ends here
