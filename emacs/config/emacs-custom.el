(require 'package-man)

;; Emacs default config
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Linum Config
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; Change backup location
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Theme
(load-theme 'wombat)

;; Comp(lete)any(thing) mode
(use-package company
  :straight t)
(add-hook 'after-init-hook 'global-company-mode)

(provide 'emacs-custom)
