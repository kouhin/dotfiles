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
(require-package 'js2-mode)
(require-package 'js2-refactor)
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
(require-package 'js-doc)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ftl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))


(add-hook 'jade-mode-hook '(lambda()
							 (defvar company-backends)
							 (add-to-list 'company-backends 'company-web-jade)))

(add-hook 'web-mode-hook '(lambda ()
							(defvar company-backends)
							(set (make-local-variable 'company-backends)
								 '((company-tern company-web-html company-yasnippet company-web-html company-css)))
							(company-mode t)))

(with-eval-after-load 'js2-mode
  (setq-default js2-show-parse-errors nil)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-strict-trailing-comma-warning nil)
  (setq-default js2-include-browser-externs nil)
  (setq-default js2-mode-show-parse-errors nil)
  (setq-default js2-mode-show-strict-warnings nil)
  (setq-default js2-highlight-external-variables nil)
  (setq-default js2-include-jslint-globals nil))

(add-hook 'js2-mode-hook '(lambda ()
							(defvar company-backends)
							(set (make-local-variable 'company-backends)
								 '((company-tern)))
							(define-key js2-mode-map (kbd "C-c i") 'js-doc-insert-function-doc)
							(define-key js2-mode-map (kbd "@") 'js-doc-insert-tag)))

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
(add-hook 'js2-jsx-mode-hook 'tern-mode)
(add-hook 'js2-mode-hook 'js2-refactor-mode)
(add-hook 'js2-jsx-mode-hook 'js2-refactor-mode)
(add-hook 'web-mode-hook 'tern-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'js2-jsx-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(defun web-mode-cur-language()
  "Show current language in web-mode."
  (interactive)
  (message (web-mode-language-at-pos)))

(defun eslint-fix ()
  "Where to display jscs-fix error output.  It can either be displayed in its own buffer, in the echo area, or not at all."
  (interactive)
  (message "eslint --fix the file %s" (buffer-file-name))
  (shell-command (concat "eslint --fix " (buffer-file-name)))
  (revert-buffer t t))

;; react-mode
(add-hook 'after-init-hook '(lambda()
							  (define-derived-mode react-mode web-mode "react")
							  (add-to-list 'auto-mode-alist '("\\.js\\'" . react-mode))
							  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . react-mode))

							  (add-hook 'react-mode-hook '(lambda()
															(message "Hello")
															(yas-activate-extra-mode 'js-mode)
															(web-mode-set-content-type "jsx")
															(setq-local web-mode-enable-auto-quoting nil)
															(defvar company-backends)
															(set (make-local-variable 'company-backends) '(company-tern company-yasnippet company-web-html company-files company-dabbrev))
															(company-mode t)
															(js2-minor-mode t)
															(js2-imenu-extras-mode t)
															(editorconfig-apply)
															))))
(add-hook 'editorconfig-mode-hook '(lambda()
									 (defvar editorconfig-indentation-alist)
									 (add-to-list
									  'editorconfig-indentation-alist
									  '(react-mode
										(web-mode-indent-style . (lambda (size) 2))
										web-mode-markup-indent-offset
										web-mode-css-indent-offset
										web-mode-code-indent-offset
										web-mode-block-padding
										web-mode-script-padding
										web-mode-style-padding
										web-mode-attr-indent-offset
										web-mode-attr-value-indent-offset))))

(provide 'init-web-mode)

;;; init-web-mode.el ends here
