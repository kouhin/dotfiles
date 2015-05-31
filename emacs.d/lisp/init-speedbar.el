;;; init-speedbar.el --- Init speedbar
;;; Commentary:
;;; Code:

(el-get-bundle sr-speedbar
  (with-eval-after-load-feature 'sr-speedbar
	(setq sr-speedbar-default-width 5)
	(setq sr-speedbar-max-width 5)
	(setq sr-speedbar-auto-refresh t)
	))

(el-get-bundle projectile-speedbar)

(with-eval-after-load 'speedbar
  (setq speedbar-show-unknown-files t)
  (setq speedbar-smart-directory-expand-flag t)
  (setq speedbar-use-images nil))

(provide 'init-speedbar)

;;; init-speedbar.el ends here
