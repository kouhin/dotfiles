;;; init-flymake --- Init flymake
;;; Commentary:
;; check file syntax
;;; Code:
(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

;(add-hook 'javascript-mode-hook 'flymake-eslint-enable)
;(add-hook 'js-mode-hook 'flymake-eslint-enable)
;;(add-hook 'typescript-mode-hook 'flymake-eslint-enable)
;(add-hook 'typescript-mode-hook
;  '(lambda() (flymake-eslint-enable)))
;(add-hook 'css-mode-hook 'flymake-stylelint-enable)

(defvar flymake-no-changes-timeout)
(setq flymake-no-changes-timeout 2)

(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "C-c ! n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "C-c ! p") 'flymake-goto-prev-error)
  (define-key flymake-mode-map (kbd "C-c ! c") 'flymake-start))

(provide 'init-flymake)

;;; init-flymake.el ends here
