;;; init-helm.el --- Init helm

;;; Commentary:
;; Find text

;;; Code:

(require-package 'helm)
(require-package 'helm-ag)
(require-package 'helm-descbinds)

(require 'helm-config)
(helm-mode t)
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'helm-descbinds)
(helm-descbinds-mode t)

;; popwin
(require-package 'popwin)
(require 'popwin)
(popwin-mode 1)
(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config)

(provide 'init-helm)
;;; init-helm.el ends here
