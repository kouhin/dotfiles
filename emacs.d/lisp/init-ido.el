;;; init-ido.el --- Init ido plugin

;;; Commentary:
;; ido plugin, open file quickly

;;; Code:

(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)

(provide 'init-ido)

;;; init-ido.el ends here
