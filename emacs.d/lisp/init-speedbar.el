;;; init-speedbar.el --- Init speedbar
;;; Commentary:
;;; Code:

(require-package 'sr-speedbar)
(require-package 'projectile-speedbar)

(require 'speedbar)
(require 'sr-speedbar)

(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq sr-speedbar-auto-refresh t)
(setq sr-speedbar-max-width 30)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 30)

(provide 'init-speedbar)

;;; init-speedbar.el ends here
