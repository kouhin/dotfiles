;;; init-speedbar.el --- Init speedbar
;;; Commentary:
;;; Code:

(require-package 'sr-speedbar)
(with-eval-after-load 'sr-speedbar
  (defvar sr-speedbar-default-width)
  (setq sr-speedbar-default-width 5)
  (defvar sr-speedbar-max-width)
  (setq sr-speedbar-max-width 5)
  (defvar sr-speedbar-auto-refresh)
  (setq sr-speedbar-auto-refresh t))

(require-package 'projectile-speedbar)

(require-package 'speedbar)
(with-eval-after-load 'speedbar
  (defvar speedbar-show-unknown-files)
  (setq speedbar-show-unknown-files t)
  (defvar speedbar-smart-directory-expand-flag)
  (setq speedbar-smart-directory-expand-flag t)
  (defvar speedbar-use-images)
  (setq speedbar-use-images nil))

(provide 'init-speedbar)

;;; init-speedbar.el ends here
