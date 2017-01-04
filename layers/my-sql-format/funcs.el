(defun goto-char-no-whitespace (before)
  (goto-char 1)
  (dotimes (i before)
    (skip-chars-forward " ")
    (forward-char))
  (skip-chars-forward " "))

(defun num-chars-before ()
  (length (replace-regexp-in-string " " "" (buffer-substring 1 (point)))))

(defun sql-format-buffer ()
  (interactive)
  (if (buffer-modified-p)
      (message "You gotta save the buffer first...")
    (let ((formatted (shell-command-to-string
                      (concat
                       "java -jar /Users/parkerlawrence/.spacemacs.d/layers/my-sql-format/sql-formatter/target/sql-formatter-0.1.0-SNAPSHOT-standalone.jar "
                       (buffer-file-name))))
          (before (num-chars-before)))
      (if (string-match "Exception in thread" formatted)
          (message formatted)
        (progn (delete-region (point-min) (point-max))
               (insert formatted)
               (goto-char-no-whitespace before))))))
