;;; init-ace-mode.el --- Init ace window

;;; Commentary:
;; quick jump

;;; Code:

;; ace-jump-mode
(el-get-bundle ace-jump-mode
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  (define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
  (add-hook 'org-mode-hook (lambda ()
							   (local-set-key (kbd "\C-c SPC") 'ace-jump-mode)))
  (with-eval-after-load-feature 'ace-jump-mode
	(ace-jump-mode-enable-mark-sync)))

;; ace-window
(el-get-bundle ace-window
  (global-set-key (kbd "C-x o") 'ace-window)
  (with-eval-after-load-feature 'ace-window
	(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))))

(provide 'init-ace-mode)
;;; init-ace-mode.el ends here
