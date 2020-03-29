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

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst
  emacs-tmp-dir
  (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

;; Show Whitespace
(setq-default show-trailing-whitespace t)

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; Theme
(load-theme 'wombat)

;; Comp(lete)any(thing) mode
(use-package company
  :straight t)
(add-hook 'after-init-hook 'global-company-mode)

;; Yasnippet
(use-package yasnippet
  :straight t)
(yas-global-mode 1)

;; I(nteractively)do(things)
(use-package ido
  :straight t)
(add-hook 'after-init-hook 'global-company-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Neo-tree
(use-package all-the-icons
  :straight t)
(use-package neotree
  :straight (:host github :repo "jaypei/emacs-neotree"
	    :branch "dev"))
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme 'icons)
(defun my/disable-line-numbers (&optional dummy)
    (display-line-numbers-mode -1))
(add-hook 'neo-after-create-hook 'my/disable-line-numbers)

;; Tab mode - possibly not good
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

(provide 'emacs-custom)
