;;; init-sws-mode.el --- Init sws mode

;;; Commentary:
;; for jade and stylus

;;; Code:

(require-package 'sws-mode)
(require-package 'jade-mode)

(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl\\'" . sws-mode))

;; flymake
(require 'flymake)
(defun flymake-jade-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
					 'flymake-create-temp-intemp))
		 (local-file (file-relative-name
					  temp-file
					  (file-name-directory buffer-file-name)))
		 (arglist (list local-file)))
	(list "jade" arglist)))
(setq flymake-err-line-patterns
	  (cons '("\\(.*\\): \\(.+\\):\\([[:digit:]]+\\)$"
			  2 3 nil 1)
			flymake-err-line-patterns))
(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.jade\\'" flymake-jade-init))

(provide 'init-sws-mode)
;;; init-sws-mode.el ends here
