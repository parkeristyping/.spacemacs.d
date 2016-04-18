(setq ejc-sql-packages
      '((clomacs :location local)
        (ejc-sql :location local)))

(defun ejc-sql/init-clomacs ()
  (use-package clomacs))

(defun ejc-sql/init-ejc-sql ()
  (use-package ejc-sql)
  ;; connections.el includes ejc-sql connection structs. It's in a separate
  ;; file because it has secrets and can't be checked into version control
  (load "~/.spacemacs.d/layers/ejc-sql/connections.el"))
