;;; init-web-mode.el --- Init web-mode

;;; Commentary:

;; Required:
;; - node
;; - eslint
;; - babel-eslint
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

(defvar web-mode)
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
							 (defvar web-mode-content-type)
							 (when (or (equal web-mode-content-type "jsx") (equal web-mode-content-type "javascript"))
							   (if (projectile-project-p)
								   (progn
									 (cond
									  ((file-exists-p (expand-file-name ".jshintrc" (projectile-project-root)))
									   (flycheck-select-checker 'javascript-jshint))
									  ((file-exists-p (expand-file-name ".eslintrc" (projectile-project-root)))
									   (flycheck-select-checker 'javascript-eslint))
									  (t
									   (flycheck-select-checker 'javascript-jshint)
									   (message 'flycheck-checker))
									 ))
								 (progn
								   (flycheck-select-checker 'javascript-jslint))))
							 (when (equal web-mode-content-type "html")
							   (flycheck-select-checker 'html-tidy))
							 (when (equal web-mode-content-type "css")
							   (flycheck-select-checker 'css-csslint))
							 (defvar company-backends)
							 (set (make-local-variable 'company-backends)
								  '((company-tern company-web-html company-css)))))
  :config
  (defvar web-mode-content-types-alist)
  (setq web-mode-content-types-alist
		'(("jsx" . "\\.js[x]?\\'"))))

(defvar json-mode)
(use-package json-mode
  :ensure t
  :defer t
  :mode "\\.json\\'")

(use-package jsfmt
  :ensure t
  :defer t)

(defvar coffee-mode)
(use-package coffee-mode
  :ensure t
  :defer t)

(defvar sws-mode)
(use-package sws-mode
  :ensure t
  :defer t)

(defvar jade-mode)
(use-package jade-mode
  :ensure t
  :defer t
  :config
  (defvar company-backends)
  (add-to-list 'company-backends 'company-web-jade))

(defvar stylus-mode)
(use-package stylus-mode
  :ensure t
  :defer t)

(defvar company-web)
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

(defvar company-tern)
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

(defvar skewer-mode)
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
