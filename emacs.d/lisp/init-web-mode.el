;;; init-web-mode.el --- Init web-mode

;;; Commentary:

;;; Code:

(use-package web-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ftl\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.scss?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode)))

(use-package json-mode
  :ensure t
  :defer t
  :mode "\\.json?\\'")

(use-package js2-mode
  :ensure t
  :defer t
  :mode "\\.js?\\'"
  :init
  (add-hook 'js-mode-hook 'js2-minor-mode))

(use-package tern
  :ensure t
  :defer t
  :init
  (add-hook 'web-mode-hook (lambda () (tern-mode t)))
  (add-hook 'js-mode-hook (lambda () (tern-mode t)))
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  :config
  (use-package company-tern
	:ensure t
	:config
	(setq company-tooltip-align-annotations t)
	(push 'company-tern company-backends)))

(provide 'init-web-mode)

;;; init-web-mode.el ends here
