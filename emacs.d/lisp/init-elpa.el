;;; init-elpa.el --- initializes ELPA settings
;;; Commentary:
;;; Code:

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "https://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.org/packages/")
						 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
	  t
	(if (or (assoc package package-archive-contents) no-refresh)
		(package-install package)
	  (progn
		(package-refresh-contents)
		(require-package package min-version t)))))

(provide 'init-elpa)
;;; init-elpa.el ends here
