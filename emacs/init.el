;; Define Config Directory
(defconst config-dir "~/.emacs.d/config/")

;; remove depr. warning for Common lisp
(setq byte-compile-warnings '(cl-functions))

;; Add Specific Configs
(add-to-list 'load-path config-dir)

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
