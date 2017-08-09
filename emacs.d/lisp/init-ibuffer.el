;;; init-ibuffer.el --- Init Ibuffer
;;; Commentary:
;;; Code:

;; ibuffer
(with-eval-after-load 'ibuffer
  (setq-default
   ibuffer-show-empty-filter-groups nil
   ibuffer-shrink-to-minimum-size t
   ibuffer-always-show-last-buffer nil
   ibuffer-sorting-mode 'recency
   ibuffer-use-header-line t
   ibuffer-saved-filter-groups
        '(("default"
           ("Magit" (name . "\*magit"))
           ("Emacs" (or (name . "^\\*scratch\\*$")
                        (name . "^\\*Messages\\*$")))
           ("Help" (or (name . "\*Help\*")
                       (name . "\*Apropos\*")
                       (name . "\*info\*"))))
          )))

(add-hook 'after-init-hook '(lambda()
                              (global-set-key (kbd "C-x C-b") 'ibuffer-other-window)))

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode t)
             (ibuffer-switch-to-saved-filter-groups "default")))

(provide 'init-ibuffer)

;;; init-ibuffer.el ends here
