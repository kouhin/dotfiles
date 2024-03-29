;;; init-yasnippet.el --- Init yasnippet

;;; Commentary:

;;; Code:
(depends 'yasnippet-snippets)
(when (depends 'yasnippet)
  (add-hook 'web-mode-hook
            '(lambda()
               (yas-activate-extra-mode 'html-mode)
               (yas-activate-extra-mode 'css-mode)))
  (add-hook 'prog-mode-hook 'yas-minor-mode)

  (with-eval-after-load 'yasnippet
    (yas-reload-all)))

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
