;;; init-markdown-mode.el --- Init markdown-mode

;;; Commentary:

;;; Code:

(require-package 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(provide 'init-markdown-mode)

;;; init-markdown-mode.el ends here
