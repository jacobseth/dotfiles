
(use-package php-mode
  :straight t)

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(require 'php-mode)
(add-hook 'php-mode-hook #'lsp)

(setq lsp-clients-php-server-command
        `("php" ,"/home/jacobseth/.config/composer/vendor/felixfbecker/language-server/bin/php-language-server.php"))

(provide 'php)
