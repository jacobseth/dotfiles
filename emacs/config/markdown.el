(require 'package-man)

(use-package yaml-mode
  :straight t)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(provide 'markdown)
