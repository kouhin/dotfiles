;;; init-direx.el --- Init direx

;;; Commentary:

;;; Code:

(require-package 'direx)
(require 'direx)
(require 'popwin)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
	  popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

(provide 'init-direx)
;;; init-direx.el ends here
