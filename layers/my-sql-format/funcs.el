(defun sql-format-buffer ()
  "Asks for a command and executes it in inferior shell with current buffer as input."
  (interactive)
  (if (buffer-modified-p)
      (message "You gotta save the buffer first...")
    (let ((formatted (shell-command-to-string
                      (concat
                       "java -jar /Users/parkerlawrence/.spacemacs.d/layers/my-sql-format/sql-formatter/target/sql-formatter-0.1.0-SNAPSHOT-standalone.jar "
                       (buffer-file-name))))
          ;; TODO: record how many chars are before point
          )
      (if (string-match "Exception in thread" formatted)
          (message formatted)
        (progn (delete-region (point-min) (point-max))
               (insert formatted)
               ;; TODO: put cursor right after # chars from above
               )))))
