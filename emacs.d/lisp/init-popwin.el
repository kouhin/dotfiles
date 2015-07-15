;;; init-popwin.el --- Init popwin

;;; Commentary:
;; push frames in popwin

;;; Code:

;; popwin
(use-package popwin
  :ensure t
  :commands (popwin-mode)
  :init
  (add-hook 'after-init-hook 'popwin-mode)
  :config
  (push '("*Ibuffer*" :position bottom :dedicated t)
		popwin:special-display-config)
  (push '(direx:direx-mode :position left :width 25 :dedicated t)
		popwin:special-display-config)
  (push '("^\*go-direx:" :regexp t :position right :width 25 :dedicated t)
		popwin:special-display-config)
  (push '(magit-status-mode :position bottom :noselect t :height 0.3)
		popwin:special-display-config)
  (push '("*magit-commit*" :noselect t :height 40 :width 80 :stick t)
		popwin:special-display-config)
  (push '("*magit-diff*" :noselect t :height 40 :width 80)
		popwin:special-display-config)
  (push '("*magit-edit-log*" :noselect t :height 15 :width 80)
		popwin:special-display-config))

(provide 'init-popwin)
;;; init-popwin.el ends here
