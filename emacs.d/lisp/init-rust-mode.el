;;; init-rust-mode.el --- Init rust
;;; Commentary:
;; Required:
;; - rust
;; - racer
;;; Code:

(require-package 'rust-mode)
(require-package 'racer)
(require-package 'flycheck-rust)

(add-hook 'rust-mode-hook '(lambda()
							 (flycheck-rust-setup)
							 (racer-mode)
 							 (define-key racer-mode-map (kbd "C-c C-j") 'racer-find-definition)
							 (define-key racer-mode-map (kbd "TAB") 'company-indent-or-complete-common)))

(provide 'init-rust-mode)

;;; init-rust-mode.el ends here
