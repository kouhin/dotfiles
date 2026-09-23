;;; init-http.el --- Init JavaScript Development Environment -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(depends 'restclient)

(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))

(provide 'init-http)

;; init-http.el ends here
