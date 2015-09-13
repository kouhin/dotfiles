;;; init-org-mode.el --- init org mode
;;; Commentary:
;;; Code:

(with-eval-after-load 'org
  (defvar org-plantuml-jar-path)
  (setq org-plantuml-jar-path
		(expand-file-name "~/plantuml.jar")))
(add-hook 'org-mode-hook '(lambda()
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
							   (plantuml   . t)))))
(provide 'init-org-mode)
;;; init-org-mode.el ends here
