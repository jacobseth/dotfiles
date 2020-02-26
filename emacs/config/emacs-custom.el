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

(provide 'emacs-custom)
