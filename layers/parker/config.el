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

(setq org-image-actual-width 50)
