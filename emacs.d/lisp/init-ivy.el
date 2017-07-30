;;; init-ivy.el --- Init ivy-mode

;;; Commentary:
;; Find text

;;; Code:
(require-package 'ivy)
(require-package 'swiper)
(require-package 'smex)
(require-package 'counsel)

(add-hook 'after-init-hook '(lambda()
                              (ivy-mode 1)
                              (global-set-key "\C-s" 'swiper)
                              (global-set-key (kbd "C-c C-r") 'ivy-resume)
                              (global-set-key (kbd "<f6>") 'ivy-resume)
                              (global-set-key (kbd "M-x") 'counsel-M-x)
                              (global-set-key (kbd "C-x C-f") 'counsel-find-file)
                              (global-set-key (kbd "<f1> f") 'counsel-describe-function)
                              (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
                              (global-set-key (kbd "<f1> l") 'counsel-load-library)
                              (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
                              (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
                              (global-set-key (kbd "C-c g") 'counsel-git)
                              (global-set-key (kbd "C-c j") 'counsel-git-grep)
                              (global-set-key (kbd "C-c k") 'counsel-ag)
                              (global-set-key (kbd "C-x l") 'counsel-locate)
                              (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
                              (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

(with-eval-after-load 'ivy
  (defvar ivy-use-virtual-buffers)
  (setq ivy-use-virtual-buffers t))

(provide 'init-ivy)
;;; init-ivy.el ends here
