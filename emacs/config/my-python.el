(require 'package-man)

(use-package python-mode
  :straight t)

(use-package pipenv
  :straight t)

(use-package python-pytest
  :straight t)

(use-package lsp-python-ms
  :straight t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                         (pipenv-mode)
                         (pipenv-activate)
                         (require 'lsp-python-ms)
                         (lsp))))  ; or lsp-deferred

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
  :hook (python-mode . yas-minor-mode))

(provide 'my-python)
