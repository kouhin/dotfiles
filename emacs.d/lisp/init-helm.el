;;; init-helm.el --- Init helm

;;; Commentary:
;; Find text

;;; Code:

(require-package 'helm)
(require-package 'helm-ag)
(require-package 'helm-descbinds)

(require 'helm-config)
(helm-mode t)

(require 'helm-descbinds)
(helm-descbinds-mode t)

(provide 'init-helm)
;;; init-helm.el ends here
