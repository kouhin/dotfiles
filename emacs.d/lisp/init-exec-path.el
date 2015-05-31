;;; init-exec-path.el --- init exec path for mac
;;; Commentary:
;;; Code:
(el-get-bundle exec-path-from-shell)
(exec-path-from-shell-initialize)
(let ((envs '("GOROOT" "GOPATH")))
  (exec-path-from-shell-copy-envs envs))

(provide 'init-exec-path)
;;; init-exec-path.el ends here
