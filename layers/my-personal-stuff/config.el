;; Load secrets, containing SQL database connection details
(load (concat (file-name-directory load-file-name) "secrets.el"))

;; Setup SQL hooks
;; This is here because sql-mode is not a package - it's build-in
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(add-hook 'sql-mode-hook
          (lambda ()
            (sql-set-product 'postgres)))

(add-hook 'sql-interactive-mode-hook
          'my-sql-interactive-mode-hook)

;; Org babel setup
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)
   (ruby . t)
   (python . t)
   (js . t)))

;; custom layouts
(spacemacs|define-custom-layout "@todo"
  :binding "t"
  :body (find-file "/Users/plawrence/gr/todo/todo.org"))
