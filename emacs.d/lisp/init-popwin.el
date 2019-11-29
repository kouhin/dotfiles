;;; init-popwin.el --- Init popwin

;;; Commentary:
;; push frames in popwin

;;; Code:

;; popwin
(when (depends 'popwin)
  (add-hook 'after-init-hook
    '(lambda()
       (require 'popwin)
       (popwin-mode)))
  (with-eval-after-load 'popwin
    (defvar popwin:special-display-config)
    (push '("*Ibuffer*" :position bottom
             :dedicated t) popwin:special-display-config)
    (push '(magit-status-mode :position bottom
             :noselect t
             :height 0.3) popwin:special-display-config)
    (push '("*magit-commit*" :noselect t
             :height 40
             :width 80
             :stick t) popwin:special-display-config)
    (push '("*magit-diff*" :noselect t
             :height 40
             :width 80) popwin:special-display-config)
    (push '("*magit-edit-log*" :noselect t
             :height 15
             :width 80) popwin:special-display-config)))

(provide 'init-popwin)
;;; init-popwin.el ends here
