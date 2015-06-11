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
  (push '("*Ibuffer*" :position bottom :dedicated t) popwin:special-display-config)
  (push '(direx:direx-mode :position left :width 25 :dedicated t)
		popwin:special-display-config)
  (push '("^\*go-direx:" :regexp t :position right :width 25 :dedicated t)
		popwin:special-display-config))

(provide 'init-popwin)
;;; init-popwin.el ends here
