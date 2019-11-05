;;; init-rust-mode.el --- Init rust
;;; Commentary:
;; Required:
;; - rust
;; - racer
;; - rustfmt
;;; Code:

(when (depends 'rust-mode)
  (when (depends 'racer)
    (when (depends 'cargo)
      (when (depends 'flycheck-rust)
        (add-hook 'rust-mode-hook
          '(lambda()
             (racer-mode)
             (cargo-minor-mode)
             (flycheck-rust-setup)
             (define-key racer-mode-map (kbd "C-c C-j") 'racer-find-definition)
             (define-key rust-mode-map (kbd "C-c C-f") 'rustfmt-format-buffer)))))))

(provide 'init-rust-mode)

;;; init-rust-mode.el ends here
