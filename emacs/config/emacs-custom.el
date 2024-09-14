(require 'package-man)

;; Emacs default config
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; modeline custom
(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1))

;; Font
(set-frame-font "Inconsolata 12" nil t)
(setq default-frame-alist '((font . "Inconsolata 12")))

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

;; Use same PATH as shell
(use-package exec-path-from-shell
  :straight t)
(exec-path-from-shell-initialize)

;; Theme
(use-package dracula-theme
  :straight t)
(load-theme 'dracula t)
;;(load-theme 'wombat)

(use-package docker-tramp
  :straight t)

;; Increase font size
(use-package zoom-frm
  :straight t)

;; Open files in Docker containers like so: /docker:drunk_bardeen:/etc/passwd
(push
 (cons
  "docker"
  '((tramp-login-program "docker")
    (tramp-login-args (("exec" "-it") ("%h") ("/bin/bash")))
    (tramp-remote-shell "/bin/sh")
    (tramp-remote-shell-args ("-i") ("-c"))))
 tramp-methods)

(defadvice tramp-completion-handle-file-name-all-completions
  (around dotemacs-completion-docker activate)
  "(tramp-completion-handle-file-name-all-completions \"\" \"/docker:\" returns
    a list of active Docker container names, followed by colons."
  (if (equal (ad-get-arg 1) "/docker:")
      (let* ((dockernames-raw (shell-command-to-string "docker ps | perl -we 'use strict; $_ = <>; m/^(.*)NAMES/ or die; my $offset = length($1); while(<>) {substr($_, 0, $offset, q()); chomp; for(split m/\\W+/) {print qq($_:\n)} }'"))
             (dockernames (cl-remove-if-not
                           #'(lambda (dockerline) (string-match ":$" dockerline))
                           (split-string dockernames-raw "\n"))))
        (setq ad-return-value dockernames))
    ad-do-it))

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

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(85 . 85))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))

;; Enable everywhere via an init hook.
(add-hook 'after-init-hook #'global-emojify-mode)

;; Or with use-package.
(use-package emojify
  :init
  (global-emojify-mode)
  :straight t)

(provide 'emacs-custom)
