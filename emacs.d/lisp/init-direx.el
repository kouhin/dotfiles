;;; init-direx.el --- Init direx

;;; Commentary:

;;; Code:

(use-package direx
  :ensure t
  :defer t
  :init
  (bind-key "C-x j" 'direx:jump-to-directory-other-window))

(provide 'init-direx)
;;; init-direx.el ends here
