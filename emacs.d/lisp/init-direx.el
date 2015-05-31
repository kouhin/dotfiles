;;; init-direx.el --- Init direx

;;; Commentary:

;;; Code:

(el-get-bundle direx
  (global-set-key (kbd "C-x j") 'direx:jump-to-directory-other-window))


(provide 'init-direx)
;;; init-direx.el ends here
