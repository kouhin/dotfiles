;;; init-ace-mode.el --- Init ace window

;;; Commentary:
;; quick jump

;;; Code:

;; ace-jump-modex
(require-package 'avy)
(require-package 'ace-window)

(add-hook 'after-init-hook '(lambda()
							  (global-set-key (kbd "C-z") 'avy-goto-char-2)
							  (global-set-key (kbd "C-c s ;") 'avy-goto-char)
							  (global-set-key (kbd "C-c s e") 'avy-goto-word-0)
							  (global-set-key (kbd "C-c s f") 'avy-goto-line)
							  (global-set-key (kbd "C-c s w") 'avy-goto-word-1)
							  (define-key isearch-mode-map (kbd "C-c ;") 'avy-isearch)
							  (avy-setup-default)
							  (global-set-key (kbd "C-x o") 'ace-window)))

(with-eval-after-load 'ace-jump-mode
  (ace-jump-mode-enable-mark-sync))

(with-eval-after-load 'ace-window
  (defvar aw-keys)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(provide 'init-ace-mode)
;;; init-ace-mode.el ends here
