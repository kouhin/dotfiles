;;; init-popwin.el --- Init popwin

;;; Commentary:
;; push frames in popwin

;;; Code:

;; popwin
(el-get-bundle! popwin)
(push '("*Ibuffer*" :position bottom :dedicated t) popwin:special-display-config)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
	  popwin:special-display-config)
(push '("^\*go-direx:" :regexp t :position right :width 25 :dedicated t)
	  popwin:special-display-config)
(popwin-mode 1)


(provide 'init-popwin)
;;; init-popwin.el ends here
