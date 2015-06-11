;;; init-ace-mode.el --- Init ace window

;;; Commentary:
;; quick jump

;;; Code:

;; ace-jump-mode
(use-package ace-jump-mode
  :ensure t
  :defer t
  :init
  (bind-key "C-c SPC" 'ace-jump-mode)
  (bind-key "C-x SPC" 'ace-jump-mode-pop-mark)
  (add-hook 'org-mode-hook (lambda ()
							 (local-set-key (kbd "\C-c SPC") 'ace-jump-mode)))
  :config
  (ace-jump-mode-enable-mark-sync))

;; ace-window
(use-package ace-window
  :ensure t
  :defer t
  :init
  (bind-key "C-x o" 'ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(provide 'init-ace-mode)
;;; init-ace-mode.el ends here
