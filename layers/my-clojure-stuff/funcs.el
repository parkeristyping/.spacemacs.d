(require 'vc)

(defun project-root (path)
  (vc-call-backend (vc-responsible-backend path) 'root path))

(defun clojure-jump-to-or-from-tests ()
  (interactive)
  (let* ((file-name (buffer-file-name))
         (root-path (expand-file-name (project-root file-name)))
         (ext (replace-regexp-in-string root-path "" file-name))
         (ext-l (split-string ext "/"))
         (dest-l
          (if (string= (car ext-l) "test")
              (cons "src" (cons (car (cdr ext-l))
                                (cdr (cdr (cdr ext-l)))))
            (cons "test" (cons (car (cdr ext-l))
                               (cons "test" (cdr (cdr ext-l)))))))
         (dest-path (concat root-path (string-join dest-l "/"))))
    (if (file-exists-p dest-path)
        (progn (find-file dest-path) 't)
      (progn
        (message "%s" (concat "Could not find corresponding file at " dest-path))
        'nil))))

(defun clojure-jump-to-or-from-test-at-point ()
  (interactive)
  (let* ((source-name (replace-regexp-in-string
                       "[^a-z0-9A-Z\-\>\?].*" ""
                       (replace-regexp-in-string "(def\\w* " "" (cider-defun-at-point))))
         (target-name
          (if (string-match "-test" source-name)
              (replace-regexp-in-string "-test" "" source-name)
            (concat source-name "-test"))))
    (if (clojure-jump-to-or-from-tests)
        (progn
          (goto-char 0)
          (re-search-forward (concat "def[a-z]* " (regexp-quote target-name)))))))
