(require 'package-man)

(use-package dockerfile-mode
  :straight t)

(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(provide 'docker)
