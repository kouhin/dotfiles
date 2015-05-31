;;; init-markdown-mode.el --- Init markdown-mode

;;; Commentary:

;;; Code:

(el-get-bundle markdown-mode
  :prepare (add-to-list 'auto-mode-alist
						'("\\.\\(md\\|mdown\\|markdown\\)\\'" . gfm-mode)))



(provide 'init-markdown-mode)

;;; init-markdown-mode.el ends here
