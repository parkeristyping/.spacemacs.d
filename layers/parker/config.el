;; SQL stuff
(setq sql-postgres-login-params
      '((user :default "asaper")
        (server :default "analytics.cfynlok9jygi.us-east-1.redshift.amazonaws.com")
        (database :default "analytics")
        (port :default 5439)
        (password)))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(add-hook 'sql-mode-hook
          (lambda ()
            (sql-set-product 'postgres)))

;; Org mode stuff
(setq org-image-actual-width '(1000))
(setq org-startup-truncated nil)

;; javascript
(setq-default js2-basic-offset 2)

;; web mode
(setq-default web-mode-code-indent-offset 2)

;; Specify program for multi-term
(setq multi-term-program "/bin/zsh")
