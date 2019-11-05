;;; init-avy-mode.el --- Init avy mode

;;; Commentary:
;; quick jump

;;; Code:

;; avy-modex
(when (depends 'avy)
  (add-hook 'after-init-hook
    '(lambda()
       (global-set-key (kbd "C-z") 'avy-goto-char-2)
       (global-set-key (kbd "C-c s ;") 'avy-goto-char)
       (global-set-key (kbd "C-c s e") 'avy-goto-word-0)
       (global-set-key (kbd "C-c s f") 'avy-goto-line)
       (global-set-key (kbd "C-c s w") 'avy-goto-word-1)
       (define-key isearch-mode-map (kbd "C-c ;") 'avy-isearch)
       (avy-setup-default))))

(provide 'init-avy-mode)
;;; init-avy-mode.el ends here
