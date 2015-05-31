;;; init-ibuffer.el --- Init Ibuffer
;;; Commentary:
;;; Code:

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-shrink-to-minimum-size t)
(setq ibuffer-always-show-last-buffer nil)
(setq ibuffer-sorting-mode 'recency)
(setq ibuffer-use-header-line t)
(setq ibuffer-saved-filter-groups
	  '(("default"
		 ("Magit" (name . "\*magit"))
		 ("Emacs" (or (name . "^\\*scratch\\*$")
				      (name . "^\\*Messages\\*$")))
		 ("Help" (or (name . "\*Help\*")
					 (name . "\*Apropos\*")
					 (name . "\*info\*"))))
		))

(add-hook 'ibuffer-mode-hook
		  '(lambda ()
			 (ibuffer-auto-mode t)
			 (ibuffer-switch-to-saved-filter-groups "default")))

(provide 'init-ibuffer)

;;; init-ibuffer.el ends here
