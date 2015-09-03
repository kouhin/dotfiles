;;; init-web-mode.el --- Init web-mode

;;; Commentary:

;; Required:
;; - node
;; - eslint
;; - jshint
;; - csslint
;; - tern
;; - json-lint
;; - coffee-script
;; - coffeelint
;; - jade
;; - stylus
;; - jsfmt

;;; Code:

(use-package web-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ftl\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  (add-hook 'web-mode-hook (lambda()
							 (set (make-local-variable 'company-backends)
								  '((company-tern company-web-html company-css)))))
  :config
  (flycheck-add-mode 'html-tidy 'web-mode)
  (flycheck-add-mode 'css-csslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-jshint 'web-mode)
  (setq web-mode-content-types-alist
		'(("jsx" . "\\.js[x]?\\'"))))

(use-package json-mode
  :ensure t
  :defer t
  :mode "\\.json\\'")

(use-package jsfmt
  :ensure t
  :defer t)

(use-package coffee-mode
  :ensure t
  :defer t)

(use-package sws-mode
  :ensure t
  :defer t)

(use-package jade-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'company-backends 'company-web-jade))

(use-package stylus-mode
  :ensure t
  :defer t)

(use-package company-web
  :ensure t
  :defer t
  :init
  (add-hook 'web-mode-hook (lambda ()
							 (set (make-local-variable 'company-backends) '(company-web-html company-files))
							 (company-mode t))))

(defadvice company-tern (before web-mode-set-up-ac-sources activate)
  "Set `tern-mode' based on current language before running company-tern."
  (if (equal major-mode 'web-mode)
	  (let ((web-mode-cur-language
			 (web-mode-language-at-pos)))
		(if (or (string= web-mode-cur-language "javascript")
				(string= web-mode-cur-language "jsx")
				)
			(unless tern-mode (tern-mode))
		  (if tern-mode (tern-mode))))))

(use-package company-tern
  :ensure t
  :defer t)

(use-package tern
  :ensure t
  :defer t
  :init
  (add-hook 'js-mode-hook (lambda() (tern-mode t)))
  (add-hook 'js2-mode-hook (lambda() (tern-mode t)))
  (add-hook 'web-mode-hook (lambda() (tern-mode t))))

(use-package skewer-mode
  :ensure t
  :defer t
  :init
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'css-mode-hook 'skewer-css-mode)
  (add-hook 'html-mode-hook 'skewer-html-mode))

(defun web-mode-cur-language()
  "Show current language in web-mode."
  (interactive)
  (message (web-mode-language-at-pos)))

(provide 'init-web-mode)

;;; init-web-mode.el ends here
