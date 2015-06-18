;;; init-utils.el --- Init some utilities
;;; Commentary:
;;; Code:

(defun byte-compile-init-dir ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))

(defun remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (add-hook 'after-save-hook
			(lambda ()
			  (if (file-exists-p (concat buffer-file-name "c"))
				  (delete-file (concat buffer-file-name "c"))))
			nil
			t))
(provide 'init-utils)
;;; init-utils.el ends here
