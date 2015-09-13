;;; init-ibuffer.el --- Init Ibuffer
;;; Commentary:
;;; Code:

;; ibuffer
(with-eval-after-load 'ibuffer
  (defvar ibuffer-show-empty-filter-groups)
  (setq ibuffer-show-empty-filter-groups nil)
  (defvar ibuffer-shrink-to-minimum-size)
  (setq ibuffer-shrink-to-minimum-size t)
  (defvar ibuffer-always-show-last-buffer)
  (setq ibuffer-always-show-last-buffer nil)
  (defvar ibuffer-sorting-mode)
  (setq ibuffer-sorting-mode 'recency)
  (defvar ibuffer-use-header-line)
  (setq ibuffer-use-header-line t)
  (defvar ibuffer-saved-filter-groups)
  (setq ibuffer-saved-filter-groups
		'(("default"
		   ("Magit" (name . "\*magit"))
		   ("Emacs" (or (name . "^\\*scratch\\*$")
						(name . "^\\*Messages\\*$")))
		   ("Help" (or (name . "\*Help\*")
					   (name . "\*Apropos\*")
					   (name . "\*info\*"))))
		  )))

(add-hook 'after-init-hook '(lambda()
							  (global-set-key (kbd "C-x C-b") 'ibuffer-other-window)))

(add-hook 'ibuffer-mode-hook
		  '(lambda ()
			 (ibuffer-auto-mode t)
			 (ibuffer-switch-to-saved-filter-groups "default")))

(provide 'init-ibuffer)

;;; init-ibuffer.el ends here
