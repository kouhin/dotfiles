;;; init-term.el --- init term
;;; Commentary:
;;; Code:
(require-package 'xterm-color)
(require 'xterm-color)

(add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
(setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
(setq font-lock-unfontify-region-function 'xterm-color-unfontify-region)

(add-hook 'eshell-mode-hook (lambda ()
							  (setq xterm-color-preserve-properties t)
							  (defvar eshell-output-filter-functions)
							  (setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))))
(add-hook 'eshell-preoutput-filter-functions 'xterm-color-filter)

(provide 'init-term)
;;; init-term.el ends here
