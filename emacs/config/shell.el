(require 'package-man)

(use-package flycheck
  :straight t)

(add-hook 'sh-mode-hook 'flycheck-mode)
(add-hook 'sh-mode-hook #'lsp)

(provide 'my-shell)
