;;; init-writing.el --- Org, Markdown, and REST documents -*- lexical-binding: t; -*-

;;; Commentary:
;; Structured documents and text-based HTTP request files.

;;; Code:

(use-package org
  :ensure nil
  :hook (org-mode . (lambda () (setq-local truncate-lines nil)))
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (js . t)
     (emacs-lisp . t)
     (python . t)
     (ruby . t)
     (perl . t)
     (dot . t)
     (css . t))))

(use-package ox-gfm
  :after org)

(use-package markdown-mode
  :mode
  (("\\.md\\'" . gfm-mode)
   ("\\.markdown\\'" . gfm-mode)))

(use-package restclient
  :mode ("\\.rest\\'" . restclient-mode))

(provide 'init-writing)
;;; init-writing.el ends here
