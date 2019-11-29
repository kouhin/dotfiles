;;; init-elpa.el --- initializes ELPA settings
;;; Commentary:

                                        ;Orinal source code: https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el

;;; Code:

(require 'package)
(custom-set-variables '(package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                                            ("melpa" . "https://melpa.org/packages/")
                                            ("org" . "https://orgmode.org/elpa/"))))
(package-initialize)

;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version) t (if (or (assoc package package-archive-contents)
                                                        no-refresh)
                                                    (if (boundp 'package-selected-packages)
                                                      ;; Record this as a package the user installed explicitly
                                                      (package-install package nil)
                                                      (package-install package))
                                                    (progn (package-refresh-contents)
                                                      (require-package package min-version t)))))


(defun depends (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err (require-package package min-version no-refresh)
    (error
      (message "Couldn't install optional package `%s': %S" package err)
      nil)))

(provide 'init-elpa)
;;; init-elpa.el ends here
