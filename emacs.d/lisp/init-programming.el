;;; init-programming.el --- Programming language support -*- lexical-binding: t; -*-

;;; Commentary:
;; Tree-sitter, language modes, completion, diagnostics, formatting, and LSP.

;;; Code:

(require 'cl-lib)
(require 'seq)
(require 'subr-x)

(declare-function apheleia-mode "apheleia" (&optional arg))
(declare-function copilot-installed-version "copilot" ())
(declare-function copilot-mode "copilot" (&optional arg))
(declare-function eglot-ensure "eglot" ())
(declare-function flymake-eslint-enable "flymake-eslint" ())
(declare-function global-treesit-auto-mode "treesit-auto" (&optional arg))
(declare-function yas-reload-all "yasnippet" ())

(defvar eglot-mode-map)
(defvar eglot-server-programs)
(defvar flymake-mode-map)
(defvar apheleia-formatter)
(defvar apheleia-mode-alist)
(defvar kouhin/state-directory)

(defconst kouhin/language-server-directory
  (expand-file-name "language-servers/" kouhin/state-directory)
  "Directory containing language servers managed by this configuration.")

(defconst kouhin/language-server-bin-directory
  (expand-file-name "bin/" kouhin/language-server-directory)
  "Directory containing managed non-Node language-server executables.")

(defconst kouhin/language-server-node-directory
  (expand-file-name "node/" kouhin/language-server-directory)
  "Npm prefix used for managed Node language servers.")

(defconst kouhin/language-server-node-bin-directory
  (expand-file-name "node_modules/.bin/"
                    kouhin/language-server-node-directory)
  "Directory containing managed Node language-server executables.")

(defconst kouhin/language-server-specs
  `((go
     :modes (go-mode go-ts-mode go-mod-mode go-mod-ts-mode
             go-work-mode go-work-ts-mode)
     :executables ("gopls")
     :command ("go" "install" "golang.org/x/tools/gopls@latest")
     :environment (("GOBIN" . ,kouhin/language-server-bin-directory)))
    (rust
     :modes (rust-mode rust-ts-mode)
     :executables ("rust-analyzer")
     :command ("rustup" "component" "add" "rust-analyzer"))
    (java
     :modes (java-mode java-ts-mode)
     :executables ("jdtls" "java-language-server")
     :command ("brew" "install" "jdtls"))
    (kotlin
     :modes (kotlin-mode)
     :executables ("kotlin-language-server")
     :command ("brew" "install" "kotlin-language-server"))
    (typescript
     :modes (js-mode js-ts-mode typescript-mode typescript-ts-mode
             typescript-tsx-mode tsx-ts-mode)
     :executables ("typescript-language-server")
     :installer node
     :command ("npm" "install" "--prefix"
               ,kouhin/language-server-node-directory
               "--no-save" "--no-audit" "--no-fund"
               "typescript@6" "typescript-language-server"
               "vscode-langservers-extracted"))
    (css
     :modes (css-mode css-ts-mode scss-mode)
     :executables ("vscode-css-language-server" "css-languageserver")
     :installer node
     :command ("npm" "install" "--prefix"
               ,kouhin/language-server-node-directory
               "--no-save" "--no-audit" "--no-fund"
               "typescript@6" "typescript-language-server"
               "vscode-langservers-extracted"))
    (html
     :modes (mhtml-mode html-ts-mode web-mode)
     :executables ("vscode-html-language-server" "html-languageserver")
     :installer node
     :command ("npm" "install" "--prefix"
               ,kouhin/language-server-node-directory
               "--no-save" "--no-audit" "--no-fund"
               "typescript@6" "typescript-language-server"
               "vscode-langservers-extracted")))
  "Language servers and the commands used to install them.")

(defvar kouhin/language-server-install-processes (make-hash-table :test #'eq)
  "Active language-server installation processes, keyed by server family.")

(defvar kouhin/language-server-install-waiters (make-hash-table :test #'eq)
  "Buffers waiting for each language-server installation.")

(defvar kouhin/language-server-install-failures (make-hash-table :test #'eq)
  "Language-server installations which failed during this Emacs session.")

(dolist (directory (list kouhin/language-server-bin-directory
                         kouhin/language-server-node-directory
                         kouhin/language-server-node-bin-directory))
  (make-directory directory t))

(dolist (directory (list kouhin/language-server-bin-directory
                         kouhin/language-server-node-bin-directory))
  (unless (member directory exec-path)
    (setq exec-path (cons directory exec-path)))
  (unless (member directory (parse-colon-path (getenv "PATH")))
    (setenv "PATH" (concat directory path-separator (getenv "PATH")))))

(defconst kouhin/eslint-project-files
  '("eslint.config.js" "eslint.config.mjs" "eslint.config.cjs"
    "eslint.config.ts" "eslint.config.mts" "eslint.config.cts")
  "Modern flat-config files which can identify an ESLint project.")

(defun kouhin/locate-project-file (names)
  "Return the first dominating directory containing one of NAMES."
  (unless (file-remote-p default-directory)
    (seq-some (lambda (name)
                (locate-dominating-file default-directory name))
              names)))

(defun kouhin/add-node-modules-path ()
  "Add the nearest project-local node_modules/.bin to this buffer."
  (unless (file-remote-p default-directory)
    (when-let* ((root
                 (locate-dominating-file
                  default-directory
                  (lambda (directory)
                    (file-directory-p
                     (expand-file-name "node_modules/.bin" directory)))))
                (bin (expand-file-name "node_modules/.bin" root)))
      (setq-local exec-path (cons bin (delete bin (copy-sequence exec-path))))
      (setq-local process-environment (copy-sequence process-environment))
      (setenv "PATH"
              (if-let* ((path (getenv "PATH")))
                  (concat bin path-separator path)
                bin)))))

(defun kouhin/project-node-executable (name)
  "Return the nearest project-local Node executable called NAME."
  (unless (file-remote-p default-directory)
    (when-let* ((root
                 (locate-dominating-file
                  default-directory
                  (lambda (directory)
                    (file-executable-p
                     (expand-file-name
                      (concat "node_modules/.bin/" name)
                      directory))))))
      (expand-file-name (concat "node_modules/.bin/" name) root))))

(defun kouhin/executable-usable-p (name)
  "Return non-nil when server executable NAME is ready to run.

Rustup can expose a rust-analyzer shim even when the component is not
installed, so validate that server explicitly."
  (and (executable-find name)
       (or (not (string-equal name "rust-analyzer"))
           (zerop (or (ignore-errors
                        (call-process name nil nil nil "--version"))
                      1)))))

(defun kouhin/formatter-usable-p (name)
  "Return non-nil when formatter executable NAME is ready to run.

Rustup can expose a rustfmt shim even when the component is not
installed, so validate that formatter explicitly."
  (and (executable-find name)
       (or (not (string-equal name "rustfmt"))
           (zerop (or (ignore-errors
                        (call-process name nil nil nil "--version"))
                      1)))))

(defun kouhin/language-server-spec ()
  "Return the language-server specification for the current major mode."
  (seq-find
   (lambda (spec)
     (apply #'derived-mode-p (plist-get (cdr spec) :modes)))
   kouhin/language-server-specs))

(defun kouhin/language-server-spec-available-p (spec)
  "Return non-nil when an executable from language-server SPEC is usable."
  (seq-some #'kouhin/executable-usable-p
            (plist-get (cdr spec) :executables)))

(defun kouhin/language-server-installer-key (spec)
  "Return the shared installer key for language-server SPEC."
  (or (plist-get (cdr spec) :installer) (car spec)))

(defun kouhin/language-server-install-log-buffer (key)
  "Return the installation log buffer for language-server installer KEY."
  (get-buffer-create (format "*language-server-install-%s*" key)))

(defun kouhin/language-server-install-finished (process _event)
  "Handle completion of language-server installation PROCESS."
  (when (memq (process-status process) '(exit signal))
    (let* ((key (process-get process 'kouhin/installer-key))
           (waiters (gethash key kouhin/language-server-install-waiters))
           (succeeded (and (eq (process-status process) 'exit)
                           (zerop (process-exit-status process))))
           (ready
            (and succeeded
                 (seq-every-p
                  (lambda (buffer)
                    (or (not (buffer-live-p buffer))
                        (with-current-buffer buffer
                          (when-let* ((spec (kouhin/language-server-spec)))
                            (kouhin/language-server-spec-available-p spec)))))
                  waiters))))
      (remhash key kouhin/language-server-install-processes)
      (remhash key kouhin/language-server-install-waiters)
      (if ready
          (progn
            (remhash key kouhin/language-server-install-failures)
            (message "Language server installation finished: %s" key)
            (dolist (buffer waiters)
              (when (buffer-live-p buffer)
                (with-current-buffer buffer
                  (condition-case error-data
                      (eglot-ensure)
                    (error
                     (message "Unable to start Eglot in %s: %s"
                              (buffer-name buffer)
                              (error-message-string error-data))))))))
        (puthash key t kouhin/language-server-install-failures)
        (display-warning
         'language-server
         (format (concat "Automatic language-server installation failed: %s. "
                         "See %s; retry with M-x kouhin/install-language-server.")
                 key (buffer-name (process-buffer process)))
         :warning)))))

(defun kouhin/start-language-server-install (spec)
  "Install the language server described by SPEC asynchronously."
  (let* ((key (kouhin/language-server-installer-key spec))
         (running (gethash key kouhin/language-server-install-processes)))
    (cl-pushnew (current-buffer)
                (gethash key kouhin/language-server-install-waiters)
                :test #'eq)
    (unless (process-live-p running)
      (let* ((command (plist-get (cdr spec) :command))
             (program (car command))
             (environment (plist-get (cdr spec) :environment))
             (log-buffer (kouhin/language-server-install-log-buffer key)))
        (if-let* ((program-path (executable-find program)))
            (let ((process-environment (copy-sequence process-environment))
                  process)
              (dolist (binding environment)
                (setenv (car binding) (cdr binding)))
              (with-current-buffer log-buffer
                (let ((inhibit-read-only t))
                  (erase-buffer)
                  (insert "$ "
                          (mapconcat #'shell-quote-argument command " ")
                          "\n\n")))
              (setq process
                    (make-process
                     :name (format "language-server-install-%s" key)
                     :buffer log-buffer
                     :command (cons program-path (cdr command))
                     :connection-type 'pipe
                     :noquery t
                     :sentinel #'kouhin/language-server-install-finished))
              (process-put process 'kouhin/installer-key key)
              (puthash key process kouhin/language-server-install-processes)
              (message "Installing language server (%s) asynchronously..." key))
          (puthash key t kouhin/language-server-install-failures)
          (display-warning
           'language-server
           (format "Cannot install language server: `%s' is not available"
                   program)
           :warning))))))

(defun kouhin/eglot-ensure-with-auto-install ()
  "Start Eglot, automatically installing a missing language server."
  (unless (file-remote-p default-directory)
    (when-let* ((spec (kouhin/language-server-spec)))
      (if (kouhin/language-server-spec-available-p spec)
          (eglot-ensure)
        (let ((key (kouhin/language-server-installer-key spec)))
          (unless (gethash key kouhin/language-server-install-failures)
            (kouhin/start-language-server-install spec)))))))

(defun kouhin/install-language-server ()
  "Install or retry installation of the server for the current buffer."
  (interactive)
  (if-let* ((spec (kouhin/language-server-spec)))
      (let ((key (kouhin/language-server-installer-key spec)))
        (remhash key kouhin/language-server-install-failures)
        (if (kouhin/language-server-spec-available-p spec)
            (progn
              (message "The language server is already installed")
              (eglot-ensure))
          (kouhin/start-language-server-install spec)))
    (user-error "No language server is configured for %s" major-mode)))

(defun kouhin/enable-node-formatter-if-available ()
  "Enable Apheleia with the appropriate available Node formatter.

Projects with a Biome configuration use Biome exclusively.  Other
projects use the formatter selected by `apheleia-mode-alist', which is
Prettier for the supported Node-related modes."
  (if (kouhin/locate-project-file '("biome.json" "biome.jsonc"))
      (when (kouhin/formatter-usable-p "biome")
        (setq-local apheleia-formatter 'biome)
        (apheleia-mode 1))
    (when (kouhin/formatter-usable-p "prettier")
      (apheleia-mode 1))))

(defun kouhin/enable-eslint-if-available ()
  "Enable Flymake ESLint when both ESLint and project configuration exist."
  (when (and (kouhin/project-node-executable "eslint")
             (kouhin/locate-project-file kouhin/eslint-project-files))
    (flymake-eslint-enable)))

(defun kouhin/setup-node-buffer ()
  "Configure formatting and language services for a Node-related buffer."
  (kouhin/add-node-modules-path)
  (kouhin/enable-node-formatter-if-available)
  (kouhin/eglot-ensure-with-auto-install))

(defun kouhin/setup-javascript-buffer ()
  "Configure a JavaScript or TypeScript buffer."
  (kouhin/setup-node-buffer)
  (kouhin/enable-eslint-if-available))

(defun kouhin/setup-formatted-language-buffer ()
  "Enable asynchronous formatting and an available language server."
  (let ((formatter
         (cond
          ((derived-mode-p 'go-mode 'go-ts-mode) "gofmt")
          ((derived-mode-p 'rust-mode 'rust-ts-mode) "rustfmt"))))
    (when (and formatter (kouhin/formatter-usable-p formatter))
      (apheleia-mode 1)))
  (kouhin/eglot-ensure-with-auto-install))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  (treesit-auto-langs
   '(css dockerfile go gomod gowork html java javascript json lua rust
     toml tsx typescript yaml))
  :config
  (global-treesit-auto-mode 1))

(use-package eglot
  :ensure nil
  :defines (eglot-mode-map eglot-server-programs)
  :commands (eglot eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  :bind
  (:map eglot-mode-map
        ("s-l a a" . eglot-code-actions)
        ("s-l a f" . eglot-code-action-quickfix)
        ("s-l r o" . eglot-code-action-organize-imports)
        ("s-l = =" . eglot-format-buffer)
        ("s-l = r" . eglot-format)
        ("s-l g d" . eglot-find-declaration)
        ("s-l g i" . eglot-find-implementation)
        ("s-l g t" . eglot-find-typeDefinition))
  :config
  (add-to-list 'eglot-server-programs
               '(((typescript-tsx-mode :language-id "typescriptreact"))
                 "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs
               '(((scss-mode :language-id "scss"))
                 "vscode-css-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs
               '(web-mode "vscode-html-language-server" "--stdio")))

(use-package flymake
  :ensure nil
  :defines flymake-mode-map
  :custom
  (flymake-no-changes-timeout 2)
  :bind
  (:map flymake-mode-map
        ("C-c ! n" . flymake-goto-next-error)
        ("C-c ! p" . flymake-goto-prev-error)
        ("C-c ! c" . flymake-start)))

(use-package flymake-eslint
  :commands flymake-eslint-enable
  :custom
  (flymake-eslint-prefer-json-diagnostics t))

(use-package apheleia
  :commands apheleia-mode
  :defines (apheleia-formatter apheleia-mode-alist)
  :config
  (add-to-list 'apheleia-mode-alist
               '(typescript-tsx-mode . prettier-typescript)))

(use-package js
  :ensure nil
  :custom
  (js-indent-level 2)
  (js-jsx-indent-level 2)
  :hook
  ((js-mode js-ts-mode) . kouhin/setup-javascript-buffer))

(use-package typescript-mode
  :preface
  (define-derived-mode typescript-tsx-mode typescript-mode "TypeScript-TSX"
    "Major mode for TypeScript files containing JSX syntax.")
  :mode
  (("\\.ts\\'" . typescript-mode)
   ("\\.tsx\\'" . typescript-tsx-mode))
  :hook
  ((typescript-mode typescript-tsx-mode typescript-ts-mode tsx-ts-mode)
   . kouhin/setup-javascript-buffer))

(use-package css-mode
  :ensure nil
  :hook
  ((css-mode css-ts-mode scss-mode) . kouhin/setup-node-buffer))

(use-package web-mode
  :mode
  (("\\.phtml\\'" . web-mode)
   ("\\.tpl\\.php\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.ftl\\'" . web-mode)
   ("\\.ejs\\'" . web-mode))
  :hook (web-mode . kouhin/setup-node-buffer))

(use-package mhtml-mode
  :ensure nil
  :hook
  ((mhtml-mode html-ts-mode) . kouhin/setup-node-buffer))

(use-package go-mode
  :mode "\\.go\\'"
  :hook
  ((go-mode go-ts-mode) . kouhin/setup-formatted-language-buffer))

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook
  ((rust-mode rust-ts-mode) . kouhin/setup-formatted-language-buffer))

(use-package cc-mode
  :ensure nil
  :hook
  ((java-mode java-ts-mode) . kouhin/eglot-ensure-with-auto-install))

(use-package kotlin-mode
  :mode "\\.kts?\\'"
  :hook (kotlin-mode . kouhin/eglot-ensure-with-auto-install))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package dockerfile-mode
  :mode "\\(?:Containerfile\\|Dockerfile\\)\\(?:\\.[^/]*\\)?\\'")

(use-package lua-mode
  :ensure nil
  :mode "\\.lua\\'")

(use-package conf-mode
  :ensure nil
  :mode ("\\.toml\\'" . conf-toml-mode))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

;; Copilot is loaded from a local checkout, so package.el does not install
;; its external dependencies automatically.
(use-package dash
  :defer t)

(use-package s
  :defer t)

(use-package f
  :defer t)

(use-package copilot
  :ensure nil
  :load-path "lisp/copilot"
  :demand t
  :custom
  (copilot-indent-offset-warning-disable t)
  :bind
  (:map copilot-mode-map
        ("s-<return>" . copilot-accept-completion))
  :config
  (when (copilot-installed-version)
    (add-hook 'prog-mode-hook #'copilot-mode)))

(provide 'init-programming)
;;; init-programming.el ends here
