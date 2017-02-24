;;; init-popwin.el --- Init popwin

;;; Commentary:
;; push frames in popwin

;;; Code:

;; popwin
(require-package 'popwin)
(add-hook 'after-init-hook '(lambda()
							  (require 'popwin)
							  (popwin-mode)))
(with-eval-after-load 'popwin
  (defvar popwin:special-display-config)
  (push '("*Ibuffer*" :position bottom :dedicated t)
		popwin:special-display-config)
  (push '(magit-status-mode :position bottom :noselect t :height 0.3)
		popwin:special-display-config)
  (push '("*magit-commit*" :noselect t :height 40 :width 80 :stick t)
		popwin:special-display-config)
  (push '("*magit-diff*" :noselect t :height 40 :width 80)
		popwin:special-display-config)
  (push '("*magit-edit-log*" :noselect t :height 15 :width 80)
		popwin:special-display-config)
  (add-hook 'helm-after-initialize-hook (lambda()
										  (defvar helm-buffer)
										  (popwin:display-buffer helm-buffer t)
										  (popwin-mode -1)))
  (add-hook'helm-cleanup-hook (lambda()
								(popwin-mode 1)))
  )

(provide 'init-popwin)
;;; init-popwin.el ends here
