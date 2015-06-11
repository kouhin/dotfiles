;;; init-yasnippet.el --- Init yasnippet

;;; Commentary:

;;; Code:
(use-package yasnippet
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'web-mode-hook
			'(lambda()
			   (yas-activate-extra-mode 'html-mode)
			   (yas-activate-extra-mode 'js2-mode)
			   (yas-activate-extra-mode 'css-mode)))
  :config
  (yas-reload-all))

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
