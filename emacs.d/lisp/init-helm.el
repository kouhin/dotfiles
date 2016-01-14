;;; init-helm.el --- Init helm

;;; Commentary:
;; Find text

;;; Code:
(require-package 'helm)
(require-package 'helm-ag)
(require-package 'helm-descbinds)

(add-hook 'after-init-hook '(lambda()
							  (global-set-key (kbd "M-x") 'helm-M-x)
							  (global-set-key (kbd "C-x b") 'helm-buffers-list)
							  (global-set-key (kbd "C-x C-f") 'helm-find-files)
							  (helm-mode)))

(with-eval-after-load 'helm
  (require 'helm-config)
  (defvar helm-boring-buffer-regexp-list)
  (setq helm-boring-buffer-regexp-list
		'("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*tramp" "\\*Minibuf" "\\*epc" "\\**\\*")))

(provide 'init-helm)
;;; init-helm.el ends here
