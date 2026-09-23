;;; init-rust-mode.el --- Init rust -*- lexical-binding: t; -*-
;;; Commentary:
;; Required:
;; - rust
;; - racer
;; - rustfmt
;;; Code:

(when (depends 'rust-mode)
  (setq-default rust-format-on-save t))

(provide 'init-rust-mode)

;;; init-rust-mode.el ends here
