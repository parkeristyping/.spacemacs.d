(mapc
 (lambda (f) (load (concat (file-name-directory (or load-file-name buffer-file-name)) "src/elisp/" f)))
 '("ejc-lib.el"
   "ejc-autocomplete.el"
   "ejc-format.el"
   "ejc-interaction.el"
   "ejc-sql.el"))
