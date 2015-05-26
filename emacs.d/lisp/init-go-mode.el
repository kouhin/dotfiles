;;; init-go-mode.el --- Init Go mode

;;; Commentary:

;;; Code:

(require-package 'go-mode)
(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
                           (local-set-key (kbd "C-c C-g") 'go-goto-imports)
                           (local-set-key (kbd "C-c C-f") 'gofmt)
                           (local-set-key (kbd "C-c C-k") 'godoc)
						   (setq gofmt-command "goimports")
                           ))
(add-hook 'before-save-hook 'gofmt-before-save)

;;auto-complete
;;(require-package 'go-autocomplete)
;;(require 'go-autocomplete)

(require-package 'company-go)
(require 'company-go)

(add-hook 'go-mode-hook (lambda ()
						  (setq company-go-show-annotation t)
						  (set (make-local-variable 'company-backends)
							   '((company-go company-yasnippet)))
						  (company-mode)))

;; eldoc
(require-package 'go-eldoc)
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; go-direx
(require-package 'go-direx)
(require 'go-direx)
(define-key go-mode-map (kbd "C-x j") 'go-direx-pop-to-buffer)

;; helm-go-package
(require-package 'helm-go-package)
(eval-after-load 'go-mode
  '(substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))

;; go-rename
(require 'compile)
(require 'go-mode)
(require 'thingatpt)

(defgroup go-rename nil
  "Options specific to the Go rename."
  :group 'go)

(defcustom go-rename-command "gorename"
  "The `gorename' command; by the default, $PATH is searched."
  :type 'string
  :group 'go-rename)

(defun go-rename (new-name)
  "Rename the entity denoted by the identifier at point to NEW-NAME, using the `gorename' tool."
  (interactive (list (read-string "New name: " (thing-at-point 'symbol))))
  (if (not buffer-file-name)
	  (error "Cannot use go-rename on a buffer without a file name"))
  ;; It's not sufficient to save the current buffer if modified,
  ;; since if gofmt-before-save is on the before-save-hook,
  ;; saving will disturb the selected region.
  (if (buffer-modified-p)
	  (error "Please save the current buffer before invoking go-rename"))
  ;; Prompt-save all other modified Go buffers, since they might get written.
  (save-some-buffers nil #'(lambda ()
							 (and (buffer-file-name)
								  (string= (file-name-extension (buffer-file-name)) ".go"))))
  (let* ((posflag (format "-offset=%s:#%d"
						  buffer-file-name
						  (1- (go--position-bytes (point)))))
		 (env-vars (go-root-and-paths))
		 (goroot-env (concat "GOROOT=" (car env-vars)))
		 (gopath-env (concat "GOPATH=" (mapconcat #'identity (cdr env-vars) ":")))
		 success)
	(with-current-buffer (get-buffer-create "*go-rename*")
	  (setq buffer-read-only nil)
	  (erase-buffer)
	  (let ((args (list go-rename-command nil t nil posflag "-to" new-name)))
		;; Log the command to *Messages*, for debugging.
		(message "Command: %s:" args)
		(message "Running gorename...")
		;; Use dynamic binding to modify/restore the environment
		(setq success (zerop (let ((process-environment (list* goroot-env gopath-env process-environment)))
							   (apply #'call-process args))))
		(insert "\n")
		(compilation-mode)
		(setq compilation-error-screen-columns nil)

		;; On success, print the one-line result in the message bar,
		;; and hide the *go-rename* buffer.
		(let ((w (display-buffer (current-buffer))))
		  (if success
			  (progn
				(message "%s" (go--buffer-string-no-trailing-space))
				(delete-window w))
			;; failure
			(message "gorename exited")
			(shrink-window-if-larger-than-buffer w)
			(set-window-point w (point-min)))))))

  ;; Reload the modified files, saving line/col.
  ;; (Don't restore the point since the text has changed.)
  ;;
  ;; TODO(adonovan): should we also do this for all other files
  ;; that were updated (the tool can print them)?
  (let ((line (line-number-at-pos))
		(col (current-column)))
	(revert-buffer t t t) ; safe, because we just saved it
	(goto-char (point-min))
	(forward-line (1- line))
	(forward-char col)))


(defun go--buffer-string-no-trailing-space ()
  "Go buffer string no trailing space."
  (replace-regexp-in-string "[\t\n ]*\\'"
							""
							(buffer-substring (point-min) (point-max))))

(provide 'init-go-mode)
;;; init-go-mode.el ends here
