;;; init-company.el --- Init company mode

;;; Commentary:
;; Auto complete

;;; Code:

(require-package 'company)
(require 'company)

(setq company-tooltip-limit 20)
(setq company-idle-delay .3)
(setq company-echo-delay 0)
(setq company-begin-commands '(self-insert-command))
(global-company-mode t)

(require-package 'yasnippet)
(require 'yasnippet)

(defun check-expansion ()
  "Check expansion."
  (save-excursion
	(if (looking-at "\\_>") t
	  (backward-char 1)
	  (if (looking-at "\\.") t
		(backward-char 1)
		(if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  "Do yas expand."
  (let ((yas-fallback-behavior 'return-nil))
	(yas-expand)))

(defun tab-indent-or-complete ()
  "Tab indent or complete."
  (interactive)
  (if (minibufferp)
	  (minibuffer-complete)
	(if (or (not yas-minor-mode)
			(null (do-yas-expand)))
		(if (check-expansion)
			(company-complete-common-or-cycle)
		  (indent-for-tab-command)))))

(global-set-key (kbd "TAB") 'tab-indent-or-complete)
(global-set-key (kbd "M-RET") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous-or-abort)

(provide 'init-company)
;;; init-company.el ends here
