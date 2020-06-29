;; Define Config Directory
(defconst config-dir "~/.emacs.d/config/")

;; Add Specific Configs
(add-to-list 'load-path config-dir)

(require 'emacs-custom)

(require 'lang-server)

(require 'shell)
(require 'notes)
(require 'javascript)
(require 'handlebars)
(require 'docker)
(require 'go)
(require 'markdown)
(require 'protobuf)
(require 'typescript)
(require 'version-control)
(require 'python)
