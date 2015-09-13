;;; init-company.el --- Init company mode

;;; Commentary:
;; Auto complete

;;; Code:

(require-package 'company)
(with-eval-after-load 'company
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
  (defvar company-tooltip-limit)
  (setq company-tooltip-limit 20)
  (defvar company-idle-delay)
  (setq company-idle-delay 0.1)
  (defvar company-echo-delay)
  (setq company-echo-delay 0)
  (defvar company-begin-commands)
  (setq company-begin-commands '(self-insert-command))
  (defvar company-tooltip-align-annotations)
  (setq company-tooltip-align-annotations t))
(add-hook 'after-init-hook 'global-company-mode)

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
	(defvar yas-minor-mode)
	(if (or (not yas-minor-mode)
			(null (do-yas-expand)))
		(if (check-expansion)
			(company-complete-common-or-cycle)
		  (indent-for-tab-command)))))

(add-hook 'company-mode-hook '(lambda()
								(define-key company-mode-map (kbd "TAB") 'tab-indent-or-complete)
								(define-key company-mode-map (kbd "M-RET") 'company-complete-common-or-cycle)
								(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
								(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
								(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
								))

(with-eval-after-load 'company-dabbrev
  (defvar company-dabbrev-downcase)
  (defvar company-dabbrev-ignore-case)
  (setq company-dabbrev-downcase nil
		company-dabbrev-ignore-case t))

(provide 'init-company)
;;; init-company.el ends here
