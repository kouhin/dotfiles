;;; init-helm.el --- Init helm

;;; Commentary:
;; Find text

;;; Code:

(el-get-bundle helm
  (add-hook 'after-init-hook (lambda ()
							   (global-set-key (kbd "M-x") 'helm-M-x)
							   (helm-mode)))
  (require 'helm-config))
(el-get-bundle helm-ag)
(el-get-bundle helm-descbinds)

(provide 'init-helm)
;;; init-helm.el ends here
