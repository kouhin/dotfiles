;;; init-exec-path.el --- init exec path for mac
;;; Commentary:
;;; Code:

(require-package 'exec-path-from-shell)
(with-eval-after-load 'exec-path-from-shell
  (defvar exec-path-from-shell-check-startup-files)
  (setq exec-path-from-shell-check-startup-files nil)
  )

(add-hook 'after-init-hook '(lambda ()
							  (when (memq window-system '(mac ns))
								(exec-path-from-shell-initialize))
							  (let ((envs '("GOROOT" "GOPATH" "RUST_SRC_PATH" "TERM")))
								(exec-path-from-shell-copy-envs envs))))

(provide 'init-exec-path)
;;; init-exec-path.el ends here
