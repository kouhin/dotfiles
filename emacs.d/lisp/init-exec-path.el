;;; init-exec-path.el --- init exec path for mac
;;; Commentary:
;;; Code:
(use-package exec-path-from-shell
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook '(lambda ()
								(exec-path-from-shell-initialize)
								(let ((envs '("GOROOT" "GOPATH")))
								  (exec-path-from-shell-copy-envs envs))
								)))

  (provide 'init-exec-path)
;;; init-exec-path.el ends here
