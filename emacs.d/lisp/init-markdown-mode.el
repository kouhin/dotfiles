;;; init-markdown-mode.el --- Init markdown-mode

;;; Commentary:

;;; Code:

(require-package 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(provide 'init-markdown-mode)

;;; init-markdown-mode.el ends here
