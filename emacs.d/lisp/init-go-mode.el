;;; init-go-mode.el --- Init Go mode
;;; Commentary:
;;; Code:
(el-get-bundle go-mode
   (add-hook 'before-save-hook 'gofmt-before-save)
  (with-eval-after-load-feature (go-mode company company-go)

	(setq gofmt-command "goimports")
	(add-hook 'go-mode-hook (lambda ()
							  (set (make-local-variable 'company-backends) '(company-go))
							  (company-mode)
							  ))))

(el-get-bundle go-company
  (with-eval-after-load-feature 'company-go
	(setq company-go-show-annotation t)))

(el-get-bundle go-def)
(el-get-bundle go-eldoc)
(el-get-bundle go-errcheck)
(el-get-bundle go-errcheck-el)
(el-get-bundle go-imports)
(el-get-bundle go-lint)
(el-get-bundle go-oracle
  :prepare (progn
			 (autoload 'go-oracle-mode "oracle" nil t)))
(el-get-bundle go-rename)
(el-get-bundle go-test)
(el-get-bundle helm-go-package)

(el-get-bundle go-direx
  :url "https://github.com/syohex/emacs-go-direx.git"
  :features go-direx
  (with-eval-after-load-feature 'go-direx
	(define-key go-mode-map (kbd "C-c j") 'go-direx-pop-to-buffer)))

(provide 'init-go-mode)
;;; init-go-mode.el ends here
