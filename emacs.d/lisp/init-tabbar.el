;;; init-tabbar.el --- Init tabbar
;;; Commentary:
;;; Code:
(el-get-bundle! tabbar
  (global-set-key (kbd "C-x <right>") 'tabbar-forward)
  (global-set-key (kbd "C-x <left>") 'tabbar-backward)
  (with-eval-after-load-feature 'tabbar
	;; disable group
	(setq tabbar-buffer-groups-function nil)

	;; set color
	(set-face-attribute
	 'tabbar-default nil
	 :background "white"
	 :height 1.0)
	(set-face-attribute
	 'tabbar-selected nil
	 :background "black"
	 :foreground "white"
	 :weight 'bold
	 :box nil)
	(set-face-attribute
	 'tabbar-unselected nil
	 :background "white"
	 :foreground "black"
	 :box nil)
	(setq tabbar-separator '(1.5))
	))


(defvar my-tabbar-displayed-buffers
  '("*scratch*")
  "*Regexps matches buffer names always included tabs.")

(defvar my-tabber-eliminate-major-mode
  '(direx:direx-mode))

(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
		 (re (regexp-opt my-tabbar-displayed-buffers))
		 (cur-buf (current-buffer))
		 (tabs (delq nil
					 (mapcar (lambda (buf)
							   (let ((name (buffer-name buf)))
								 (when (or (string-match re name)
										   (not (memq (aref name 0) hides)))
								   (unless (memq (with-current-buffer buf major-mode)
												 my-tabber-eliminate-major-mode)
									 buf))))
							 (buffer-list)))))
	      ;;; Always include the current buffer.
	(if (memq cur-buf tabs)
		tabs
	  (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; delete left buttons
(dolist (btn '(tabbar-buffer-home-button
			   tabbar-scroll-left-button
			   tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
				 (cons "" nil))))

(setq tabbar-auto-scroll-flag nil)
(defadvice tabbar-buffer-tab-label (around my-tabbar-ad-dont-shorten activate)
  (let ((tabbar-auto-scroll-flag t))
	ad-do-it))


(tabbar-mode)

;; Distinct same name buffers
(require 'uniquify
		 (with-eval-after-load-feature 'uniquify
		   (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
		   ))


(provide 'init-tabbar)
;;; init-tabbar.el ends here
