;; Define Config Directory
(defconst config-dir "~/.emacs.d/config/")

;; remove depr. warning for Common lisp
(setq byte-compile-warnings '(cl-functions))

;; Add Specific Configs
(add-to-list 'load-path config-dir)

;; Custom Functions
(defun daily-notes ()
  (interactive)
  (let ((daily-name (format-time-string "%Y-%m-%d")))
    (copy-file "~/notes/template.org" (expand-file-name (concat "~/notes/" daily-name ".org")))
    (find-file (expand-file-name (concat "~/notes/" daily-name ".org")))))

(require 'emacs-custom)

(require 'lang-server)

(require 'my-shell)
(require 'notes)
(require 'javascript)
(require 'handlebars)
(require 'docker)
(require 'go)
(require 'markdown)
(require 'protobuf)
(require 'typescript)
(require 'version-control)
(require 'my-python)
(require 'my-terraform)
