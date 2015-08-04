;;; init-flycheck --- Init flycheck

;;; Commentary:
;; check file syntax

;;; Code:

(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode)
  :config
  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
				(append flycheck-disabled-checkers
						'(javascript-jshint json-jsonlist)))

;;  ;; disable json-jsonlist checking for json files
;;  (setq-default flycheck-disabled-checkers
;;				(append flycheck-disabled-checkers
;;						'(json-jsonlist)))

  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'js-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-mode))

  (provide 'init-flycheck)

;;; init-flycheck.el ends here
