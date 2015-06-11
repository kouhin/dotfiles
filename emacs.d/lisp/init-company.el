;;; init-company.el --- Init company mode

;;; Commentary:
;; Auto complete

;;; Code:

(use-package company
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (eval-and-compile
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
			  (indent-for-tab-command))))))
  :config
  (bind-key "TAB" 'tab-indent-or-complete company-mode-map)
  (bind-key "M-RET" 'company-complete-common-or-cycle company-mode-map)

  (custom-set-faces
   '(company-preview
	 ((t (:foreground "darkgray" :underline t))))
   '(company-preview-common
	 ((t (:inherit company-preview))))
   '(company-tooltip
	 ((t (:background "lightgray" :foreground "black"))))
   '(company-tooltip-selection
	 ((t (:background "steelblue" :foreground "white"))))
   '(company-tooltip-common
	 ((((type x)) (:inherit company-tooltip :weight bold))
	  (t (:inherit company-tooltip))))
   '(company-tooltip-common-selection
	 ((((type x)) (:inherit company-tooltip-selection :weight bold))
	  (t (:inherit company-tooltip-selection)))))
  (setq company-tooltip-limit 20)
  (setq company-idle-delay 0.1)
  (setq company-echo-delay 0)
  (setq company-begin-commands '(self-insert-command))

  (bind-key "TAB" 'company-complete-common-or-cycle company-active-map)
  (bind-key "C-n" 'company-select-next-or-abort company-active-map)
  (bind-key "C-p" 'company-select-previous-or-abort company-active-map)

  (with-eval-after-load 'company-dabbrev
	(setq company-dabbrev-downcase nil
		  company-dabbrev-ignore-case t))
  )

(provide 'init-company)
;;; init-company.el ends here
