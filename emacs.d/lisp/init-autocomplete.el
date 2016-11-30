;;; init-autocomplete.el --- Init auto-complete

;;; Commentary:
;; setting for auto-complete

;;; Code:

(require-package 'auto-complete)

(with-eval-after-load 'auto-complete
  (defvar ac-ignore-case)
  (setq ac-ignore-case nil)
  ;; Enable auto-complete mode other than default enable modes
  (dolist (mode '(rjsx-mode
				  markdown-mode
				  fundamental-mode
				  org-mode
				  text-mode))
	(defvar ac-modes)
	(add-to-list 'ac-modes mode)))

(add-hook 'after-init-hook '(lambda ()
							  (require 'auto-complete-config)
							  (ac-flyspell-workaround)
							  (ac-linum-workaround)
							  (ac-config-default)))

(add-hook 'auto-complete-mode-hook '(lambda()
									  (add-to-list 'ac-sources 'ac-source-yasnippet)
									  (define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
									  (define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
									  (define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
									  (define-key ac-completing-map (kbd "<tab>") 'ac-complete)
									  (define-key ac-completing-map (kbd "C-i") 'ac-complete)

									  (global-set-key (kbd "C-M-i") 'auto-complete)
									  (define-key lisp-interaction-mode-map (kbd "C-M-i") 'auto-complete)
									  (define-key emacs-lisp-mode-map (kbd "C-M-i") 'auto-complete)))

(provide 'init-autocomplete)
;;; init-autocomplete.el ends here
