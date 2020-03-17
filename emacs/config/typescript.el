(require 'package-man)

(use-package web-mode
  :straight t
)

(use-package tide
  :straight t
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode)
              (setq web-mode-css-indent-offset 2)
              (setq web-mode-code-indent-offset 2)
              (setq web-mode-indent-style 2)
              (setq web-mode-markup-indent-offset 2))))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)


(setq typescript-indent-level 2
      typescript-expr-indent-offset 2)

;; Stop auto-quoting after '=' in tsx
(setq web-mode-enable-auto-quoting nil)

(provide 'typescript)
