;;; init-term.el --- init term
;;; Commentary:
;;; Code:

(setq system-uses-terminfo nil)

;; ansi-color
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
(add-hook 'eshell-preoutput-filter-functions 'ansi-color-filter-apply)
(add-hook 'eshell-preoutput-filter-functions 'ansi-color-apply)

(provide 'init-term)
;;; init-term.el ends here
