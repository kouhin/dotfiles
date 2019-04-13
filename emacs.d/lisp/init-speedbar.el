;;; init-speedbar.el --- Init speedbar
;;; Commentary:
;;; Code:


(custom-set-variables
 '(sr-speedbar-default-width 5)
 '(sr-speedbar-max-width 5)
 '(sr-speedbar-auto-refresh t)
 '(speedbar-show-unknown-files t)
 '(speedbar-smart-directory-expand-flag t)
 '(speedbar-use-images nil))

(depends 'sr-speedbar)
(depends 'projectile-speedbar)
(depends 'speedbar)

(provide 'init-speedbar)

;;; init-speedbar.el ends here
