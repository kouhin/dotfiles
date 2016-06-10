;;; init-sws-mode.el --- Init sws-mode

;;; Commentary:

;;; Code:

;; Required:
;; - coffee-script
;; - coffeelint
;; - jade
;; - stylus

(require-package 'coffee-mode)
(require-package 'sws-mode)
(require-package 'jade-mode)
(require-package 'stylus-mode)

(add-hook 'jade-mode-hook '(lambda()
							 (defvar company-backends)
							 (add-to-list 'company-backends 'company-web-jade)))

(provide 'init-sws-mode)
;;; init-sws-mode.el ends here
