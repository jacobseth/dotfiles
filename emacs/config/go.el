(require 'package-man)

;; set path for gopls
(setenv "PATH" (concat (getenv "PATH") ":/home/jacobseth/go/bin"))
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin"))

(flycheck-def-config-file-var flycheck-go-revive-config go-revive "revive_config.toml")
(setq flycheck-go-revive-executable "/home/jacobseth/go/bin/revive")
(defun flycheck-gorevive--find-project-root (_checker)
  (locate-dominating-file (or buffer-file-name default-directory) "revive_config.toml"))

(flycheck-define-checker go-revive
  "Drop-in replacement of golint.
See URL `https://github.com/mgechev/revive'."
  :command ("revive"
            (config-file "--config" flycheck-go-revive-config)
            source)
  :working-directory flycheck-gorevive--find-project-root
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": " (message) line-end))
  :modes go-mode
  :next-checkers (go-vet
                  ;; Fall back, if go-vet doesn't exist
                  go-build go-test go-errcheck go-unconvert))

(add-to-list 'flycheck-checkers 'go-revive)

(use-package go-mode
  :straight t)

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :straight t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0))

;; Optional - provides snippet support.
(use-package yasnippet
  :straight t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(provide 'go)
