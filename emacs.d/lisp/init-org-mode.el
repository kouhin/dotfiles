;;; init-org-mode.el --- init org mode
;;; Commentary:
;;; Code:

(require-package 'org-plus-contrib)
(require-package 'ox-gfm)

(with-eval-after-load 'org
  (setq-default org-plantuml-jar-path
        (expand-file-name "~/plantuml.jar")))
(add-hook 'org-mode-hook '(lambda()
                            (setq truncate-lines nil)
                            (require 'ox-gfm)
                            (require 'ox-taskjuggler)
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
