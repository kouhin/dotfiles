;;; init-speedbar.el --- Init speedbar
;;; Commentary:
;;; Code:

(require-package 'sr-speedbar)
(require-package 'projectile-speedbar)

(require 'speedbar)
(require 'sr-speedbar)
(require 'projectile-speedbar)

(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq sr-speedbar-default-width 5)
(setq sr-speedbar-max-width 5)
(setq sr-speedbar-auto-refresh t)

(provide 'init-speedbar)

;;; init-speedbar.el ends here
