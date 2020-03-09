(require 'package-man)

(use-package go-mode
  :straight t)

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(require 'go-mode)

(add-hook 'go-mode-hook #'lsp)

(provide 'go)