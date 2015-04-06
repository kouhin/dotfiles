;;; init-auto-complete.el --- Init auto-complete

;;; Commentary:

;;; Code:


;; should be loaded after yasnippet
(require-package 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories
             (expand-file-name "lisp/custom-dicts" user-emacs-directory))

;; if TAB is pressed, first indent current line, then try to complete
(setq tab-always-indent 'complete)

;; prevent auto-complete from automatically expanding
(setq-default ac-expand-on-auto-complete nil)
(setq-default ac-auto-start nil)
;; use TAB to explicitily trigger the auto-complete func
(ac-set-trigger-key "TAB")
;; (setq-default ac-dwim nil)

(after-load 'init-yasnippet
  (set-default 'ac-sources
               '(ac-source-dictionary
                 ac-source-words-in-buffer
                 ac-source-words-in-same-mode-buffers
                 ac-source-words-in-all-buffer
                 ac-source-functions
                                ac-source-yasnippet)))

(provide 'init-auto-complete)
;;; init-auto-complete.el ends here
