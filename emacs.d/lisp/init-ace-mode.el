;;; init-ace-mode.el --- Init ace window

;;; Commentary:
;; quick jump

;;; Code:

;; ace-jump-mode
(require-package 'ace-jump-mode)
(require-package 'ace-window)

(add-hook 'after-init-hook '(lambda()
							  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
							  (global-set-key (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
							  (global-set-key (kbd "C-x o") 'ace-window)))

(add-hook 'org-mode-hook (lambda ()
						   (local-set-key (kbd "C-c SPC") 'ace-jump-mode)))

(with-eval-after-load 'ace-jump-mode
  (ace-jump-mode-enable-mark-sync))

(with-eval-after-load 'ace-window
  (defvar aw-keys)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(provide 'init-ace-mode)
;;; init-ace-mode.el ends here
