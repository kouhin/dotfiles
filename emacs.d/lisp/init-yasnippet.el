;;; init-yasnippet.el --- Init yasnippet

;;; Commentary:

;;; Code:
(el-get-bundle yasnippet-snippets)

(el-get-bundle yasnippet
  (add-hook 'web-mode-hook
			'(lambda()
			   (yas-activate-extra-mode 'html-mode)
			   (yas-activate-extra-mode 'js2-mode)
			   (yas-activate-extra-mode 'css-mode)))
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (with-eval-after-load-feature 'yasnippet
	(setq yas-snippet-dirs
		  '("~/.emacs.d/el-get/yasnippet-snippets"))
	(yas-reload-all)))

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
