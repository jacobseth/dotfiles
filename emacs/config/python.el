(require 'package-man)

(use-package python-mode
  :straight t)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(use-package lsp-python-ms
  :straight t)
(add-hook 'python-mode-hook #'lsp) ; or lsp-deferred

(use-package lsp-python-ms
  :straight t
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp))))  ; or lsp-deferred

(provide 'python)
