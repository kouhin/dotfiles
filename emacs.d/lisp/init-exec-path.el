;;; init-exec-path.el --- init exec path for mac
;;; Commentary:
;;; Code:
(require-package 'exec-path-from-shell)

(after-load 'exec-path-from-shell
	    (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "GOPATH"))
	      (add-to-list 'exec-path-from-shell-variables var)))


(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)
;;; init-exec-path.el ends here
