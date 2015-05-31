;;; init-yaml-mode --- Init Yaml mode
;;; Commentary:
;;; Code:

(el-get-bundle yaml-mode
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-hook 'yaml-mode-hook
			'(lambda ()
			   (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(provide 'init-yaml-mode)

;;; init-yaml-mode.el ends here
