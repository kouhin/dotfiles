;;; init-exec-path.el --- init exec path for mac
;;; Commentary:
;;; Code:

(require-package 'exec-path-from-shell)
(with-eval-after-load 'exec-path-from-shell
  (defvar exec-path-from-shell-variables)
  (dolist (var '("GOROOT" "GOPATH" "PATH" "RUST_SRC_PATH" "TERM"))
    (add-to-list 'exec-path-from-shell-variables var)))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)
;;; init-exec-path.el ends here
