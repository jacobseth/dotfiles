(require 'package-man)

(use-package yaml-mode
  :straight t)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(use-package markdown-mode
  :straight t
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(provide 'markdown)
