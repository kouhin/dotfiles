;;; early-init.el --- Early startup configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Settings which must take effect before package activation and frame setup.

;;; Code:

(defvar native-comp-async-report-warnings-errors)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      package-enable-at-startup nil
      frame-inhibit-implied-resize t
      ;; Third-party native-comp diagnostics remain logged, but should not
      ;; interrupt startup by displaying the *Warnings* buffer.
      native-comp-async-report-warnings-errors 'silent)

(dolist (parameter '((menu-bar-lines . 0)
                     (tool-bar-lines . 0)
                     (vertical-scroll-bars)))
  (add-to-list 'default-frame-alist parameter))

;; The emacs-plus app cask keeps its generated site-start file outside the
;; default load-path.  It configures PATH injection and native compilation.
(when (and (eq system-type 'darwin)
           (not (boundp 'ns-emacs-plus-version)))
  (let ((site-start (expand-file-name "../site-lisp/site-start.el"
                                      data-directory)))
    (when (file-readable-p site-start)
      (load site-start nil t))))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 32 1024 1024)
                  gc-cons-percentage 0.1)))

(provide 'early-init)
;;; early-init.el ends here
