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

(require-package 'web-mode)
(require-package 'json-mode)
(require-package 'jsfmt)
(require-package 'coffee-mode)
(require-package 'sws-mode)
(require-package 'jade-mode)
(require-package 'stylus-mode)
(require-package 'company-web)
(require-package 'company-tern)
(require-package 'tern)
(require-package 'skewer-mode)

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

(with-eval-after-load 'web-mode
  (defvar web-mode-content-types-alist)
  (setq web-mode-content-types-alist
		'(("jsx" . "\\.js[x]?\\'"))))

(add-hook 'jade-mode-hook '(lambda()
							 (defvar company-backends)
							 (add-to-list 'company-backends 'company-web-jade)))

(add-hook 'web-mode-hook '(lambda ()
							(set (make-local-variable 'company-backends) '(company-web-html company-files))
							(company-mode t)

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
									  (flycheck-select-checker 'javascript-jshint))
									 ))
								(flycheck-select-checker 'javascript-jshint)))
							(when (equal web-mode-content-type "html")
							  (flycheck-select-checker 'html-tidy))
							(when (equal web-mode-content-type "css")
							  (flycheck-select-checker 'css-csslint))

							(defvar company-backends)
							(set (make-local-variable 'company-backends)
								 '((company-tern company-web-html company-css)))
							))

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

(add-hook 'js-mode-hook 'tern-mode)
(add-hook 'js2-mode-hook 'tern-mode)
(add-hook 'web-mode-hook 'tern-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(defun web-mode-cur-language()
  "Show current language in web-mode."
  (interactive)
  (message (web-mode-language-at-pos)))

(provide 'init-web-mode)

;;; init-web-mode.el ends here
