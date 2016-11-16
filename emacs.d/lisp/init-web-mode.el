;;; init-web-mode.el --- Init web-mode

;;; Commentary:

;; Required:
;; - node
;; - eslint
;; - tern

;;; Code:

(require-package 'web-mode)
(require-package 'json-mode)
(require-package 'tern)
(require-package 'tern-auto-complete)
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
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))

(with-eval-after-load 'tern
  (require 'tern-auto-complete)
  (defvar tern-ac-js-major-modes '(js2-mode js2-jsx-mode js-mode javascript-mode react-mode))
  (tern-ac-setup))

(defun web-mode-cur-language()
  "Show current language in web-mode."
  (interactive)
  (message (web-mode-language-at-pos)))

(if (executable-find "eslint")
	(progn
	  (defun eslint-fix ()
		"Where to display jscs-fix error output.  It can either be displayed in its own buffer, in the echo area, or not at all."
		(interactive)
		(message "eslint --fix the file %s" (buffer-file-name))
		(shell-command (concat "eslint --fix " (buffer-file-name)))
		(revert-buffer t t)))
  (message "Please install eslint: 'npm install -g eslint-cli'."))

;; react-mode
(add-hook 'after-init-hook '(lambda()
							  (define-derived-mode react-mode web-mode "react")
							  (add-to-list 'auto-mode-alist '("\\.js\\'" . react-mode))
							  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . react-mode))

							  (add-hook 'react-mode-hook '(lambda()
															(yas-activate-extra-mode 'js-mode)
															(web-mode-set-content-type "jsx")
															(setq-local web-mode-enable-auto-quoting nil)
															(add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
															(add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
															(add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
															(add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
															(editorconfig-apply)
															))))

(add-hook 'react-mode-hook '(lambda()
							  (tern-mode)))

(add-hook 'editorconfig-mode-hook '(lambda()
									 (defvar editorconfig-indentation-alist)
									 (add-to-list
									  'editorconfig-indentation-alist
									  '(react-mode
										(web-mode-indent-style . (lambda (size) 2))
										web-mode-markup-indent-offset
										web-mode-css-indent-offset
										web-mode-code-indent-offset
										web-mode-attr-indent-offset
										web-mode-attr-value-indent-offset
										web-mode-block-padding
										web-mode-script-padding
										web-mode-style-padding))))

(provide 'init-web-mode)

;;; init-web-mode.el ends here
