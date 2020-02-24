;; Define Config Directory
(defconst config-dir "~/.emacs.d/config/")

;; Add Specific Configs
(add-to-list 'load-path config-dir)

(require 'emacs-custom)
(require 'shell)
(require 'notes)
