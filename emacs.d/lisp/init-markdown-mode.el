;;; init-markdown-mode.el --- Init markdown-mode

;;; Commentary:

;;; Code:

(el-get-bundle markdown-mode
  (add-hook 'markdown-mode-hook '(lambda()
								   (local-set-key (kbd "RET") 'comment-indent-new-line)))
  :prepare (add-to-list 'auto-mode-alist
						'("\\.\\(md\\|mdown\\|markdown\\)\\'" . gfm-mode)))

(el-get-bundle gh-md
  :url "https://github.com/emacs-pe/gh-md.el.git"
  :type github
  :pkgname "emacs-pe/gh-md.el")

(provide 'init-markdown-mode)

;;; init-markdown-mode.el ends here
