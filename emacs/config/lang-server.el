(require 'package-man)

(use-package lsp-mode
  :straight t)
(use-package lsp-ui
  :straight t)

(setq lsp-auto-configure t)

(provide 'lang-server)
