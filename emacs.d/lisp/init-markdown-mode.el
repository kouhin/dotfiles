;;; init-markdown-mode.el --- Init markdown-mode

;;; Commentary:

;;; Code:
(use-package markdown-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist
			   '("\\.\\(md\\|mdown\\|markdown\\)\\'" . gfm-mode))
  :config
  (bind-key "RET" 'comment-indent-new-line markdown-mode-map))

(use-package gh-md
  :ensure t
  :defer t)

(provide 'init-markdown-mode)

;;; init-markdown-mode.el ends here
