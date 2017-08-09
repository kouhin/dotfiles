;;; init-speedbar.el --- Init speedbar
;;; Commentary:
;;; Code:

(require-package 'sr-speedbar)
(with-eval-after-load 'sr-speedbar
  (setq-default
   sr-speedbar-default-width 5
   sr-speedbar-max-width 5
   sr-speedbar-auto-refresh t))

(require-package 'projectile-speedbar)

(require-package 'speedbar)
(with-eval-after-load 'speedbar
  (setq-default
   speedbar-show-unknown-files t
   speedbar-smart-directory-expand-flag t
   speedbar-use-images nil))

(provide 'init-speedbar)

;;; init-speedbar.el ends here
