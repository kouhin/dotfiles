;;; init-exec-path.el --- init exec path for mac
;;; Commentary:
;;; Code:

(require-package 'exec-path-from-shell)
(add-hook 'after-init-hook '(lambda ()
							  (exec-path-from-shell-initialize)
							  (let ((envs '("GOROOT" "GOPATH" "RUST_SRC_PATH")))
								(exec-path-from-shell-copy-envs envs))))

(provide 'init-exec-path)
;;; init-exec-path.el ends here
