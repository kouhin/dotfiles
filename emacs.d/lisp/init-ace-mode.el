;;; init-ace-mode.el --- Init ace window

;;; Commentary:
;; quick jump

;;; Code:

;; ace-jump-mode
(require-package 'ace-jump-mode)
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; ace-window
(require-package 'ace-window)
(require 'ace-window)

(global-set-key (kbd "C-x o") 'ace-window)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(provide 'init-ace-mode)
;;; init-ace-mode.el ends here
