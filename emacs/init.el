;; Emacs default config
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Linum Config
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(defconst init-dir "~/.emacs.d/")
(defconst packages-dir (concat init-dir "packages/"))

;; Use Package
(eval-when-compile
  (add-to-list 'load-path (concat packages-dir "use-package"))
  (require 'use-package))
