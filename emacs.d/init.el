;;; init.el --- bootstrap

;;; Commentary:
;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq gc-cons-threshold (* 128 1024 1024))

(let ((minver "25.0"))
  (when (version<= emacs-version "25.0")
	(error "Your Emacs is too old -- this config requires v%s or higher" minver)))

(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-gui* (display-graphic-p))

(when *is-gui*
  (load-theme 'deeper-blue))

(setq user-emacs-directory "~/.emacs.d")
(add-to-list
 'load-path
 (expand-file-name "lisp" user-emacs-directory))

;; create auto-save file in ~/.emacs.d/backup
(defconst emacs-tmp-dir "~/.emacs.d/tmp/")
(unless (file-exists-p emacs-tmp-dir)
  (make-directory emacs-tmp-dir t))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
	  emacs-tmp-dir)

(when *is-a-mac*
  (setq ns-function-modifier 'hyper)
  (setq ns-option-modifier 'meta)
  (setq ns-command-modifier 'super)
  (setq mac-function-modifier 'hyper)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super))

(setq ring-bell-function 'ignore)

;;set all coding systems to utf-8
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'init-elpa)
(require 'init-exec-path)
(require 'init-editing-utils)
(require 'init-ibuffer)
(require 'init-yasnippet)
(require 'init-autocomplete)
(require 'init-flycheck)

(require 'init-ivy)
(require 'init-popwin)
(require 'init-projectile)
(require 'init-avy-mode)
(require 'init-speedbar)
(require 'init-git)
(require 'init-neotree)

;; Major modes
(require 'init-org-mode)
(require 'init-web-mode)
(require 'init-sws-mode)
(require 'init-typescript-mode)
(require 'init-markdown-mode)
(require 'init-go-mode)
(require 'init-toml-mode)
(require 'init-yaml-mode)
(require 'init-dockerfile-mode)
(require 'init-rust-mode)
(require 'init-utils)

(setq custom-file (expand-file-name "emacs-custom.el" emacs-tmp-dir))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)

;;; init.el ends here
(put 'magit-clean 'disabled nil)
