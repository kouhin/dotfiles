;;; init-dockerfile-mode.el --- Init dockerfile mode
;;; Commentary:
;;; Code:

(el-get-bundle dockerfile-mode
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(provide 'init-dockerfile-mode)

;;; init-dockerfile-mode.el ends here
