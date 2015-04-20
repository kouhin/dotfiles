;;; init-direx.el --- Init direx

;;; Commentary:

;;; Code:

(require-package 'direx)
(require 'direx)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

(provide 'init-direx)
;;; init-direx.el ends here
