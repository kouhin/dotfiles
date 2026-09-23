;;; init.el --- Emacs configuration entry point -*- lexical-binding: t; -*-

;;; Commentary:
;; Bootstrap package.el and load the domain-specific configuration modules.

;;; Code:

(when (version< emacs-version "31.1")
  (error "This configuration requires Emacs 31.1 or newer"))

(defconst kouhin/emacs-directory
  (file-name-directory (or load-file-name user-init-file))
  "Root directory of this Emacs configuration.")

(defconst kouhin/state-directory
  (expand-file-name "tmp/" user-emacs-directory)
  "Directory for generated and persistent Emacs state.")

(dolist (directory (list kouhin/state-directory
                         (expand-file-name "auto-save-list/"
                                           kouhin/state-directory)
                         (expand-file-name "backups/" kouhin/state-directory)
                         (expand-file-name "auto-saves/" kouhin/state-directory)
                         (expand-file-name "transient/" kouhin/state-directory)))
  (make-directory directory t))

(setq custom-file (expand-file-name "custom.el" kouhin/state-directory))
(add-to-list 'load-path (expand-file-name "lisp" kouhin/emacs-directory))

(require 'package)

;; Do not let obsolete installed packages shadow Emacs 31 built-ins.
(setq package-load-list '((org-plus-contrib nil)
                          (org nil)
                          (editorconfig nil)
                          (lua-mode nil)
                          (toml-mode nil)
                          (json-mode nil)
                          (0blayout nil)
                          (add-node-modules-path nil)
                          (ag nil)
                          (biomejs-format nil)
                          (coffee-mode nil)
                          (company nil)
                          (company-box nil)
                          (counsel nil)
                          (flx nil)
                          (flymake-diagnostic-at-point nil)
                          (gh-md nil)
                          (highlight-indentation nil)
                          (ivy nil)
                          (jade-mode nil)
                          (js-doc nil)
                          (magit-gitflow nil)
                          (osx-clipboard nil)
                          (popwin nil)
                          (prettier-js nil)
                          (projectile nil)
                          (pug-mode nil)
                          (rg nil)
                          (smex nil)
                          (stylus-mode nil)
                          (swiper nil)
                          (sws-mode nil)
                          (syntax-subword nil)
                          (undo-tree nil)
                          (vue-mode nil)
                          all)
      package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/"))
      package-archive-priorities '(("gnu" . 10)
                                   ("melpa" . 5)))

(package-initialize)

(require 'use-package)
(require 'bytecomp)
(require 'cl-lib)
(require 'warnings)
(setq use-package-always-ensure t
      use-package-compute-statistics t
      use-package-expand-minimally t
      use-package-verbose t)

;; A clean installation byte-compiles third-party packages while evaluating
;; their use-package declarations.  Emacs 31 reports many harmless upstream
;; compatibility warnings here.  Filter only warnings produced inside
;; `package--compile'; compilation errors and our own diagnostics remain
;; visible and fatal.
(let ((package-compiler (symbol-function 'package--compile)))
  (cl-letf
      (((symbol-function 'package--compile)
        (lambda (package)
          (let ((warning-logger
                 (symbol-function 'byte-compile-log-warning))
                (warning-display (symbol-function 'display-warning))
                (byte-compile-warnings nil)
                (inhibit-message t))
            (cl-letf
                (((symbol-function 'byte-compile-log-warning)
                  (lambda (message &optional fill level)
                    (unless (eq level :warning)
                      (funcall warning-logger message fill level))))
                 ((symbol-function 'display-warning)
                  (lambda (type message &optional level buffer-name)
                    (unless (eq level :warning)
                      (funcall warning-display
                               type message level buffer-name)))))
              (funcall package-compiler package))))))
    (require 'init-core)
    (require 'init-completion)
    (require 'init-tools)
    (require 'init-programming)
    (require 'init-writing)))

(when (file-readable-p custom-file)
  (load custom-file nil t))

(provide 'init)
;;; init.el ends here
