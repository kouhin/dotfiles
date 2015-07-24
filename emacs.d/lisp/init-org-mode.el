;;; init-org-mode.el --- init org mode
;;; Commentary:
;;; Code:

(use-package org
  :ensure t
  :pin manual
  :init
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sh         . t)
	 (js         . t)
	 (emacs-lisp . t)
	 (perl       . t)
	 (scala      . t)
	 (clojure    . t)
	 (python     . t)
	 (ruby       . t)
	 (dot        . t)
	 (css        . t)
	 (plantuml   . t)))
  (setq org-plantuml-jar-path
		(expand-file-name "~/plantuml.jar")))

(provide 'init-org-mode)
;;; init-org-mode.el ends here
