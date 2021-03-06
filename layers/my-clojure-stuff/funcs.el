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

(defun clojure-indent-defun-at-point ()
  (interactive)
  (let ((bounds (cider-defun-at-point 't)))
    (save-excursion
      (indent-region (car bounds)
                     (car (cdr bounds)))
      (message "Indented defun at point."))))

(defun clojure-indent-region ()
  (interactive)
  (save-excursion
    (indent-region (region-beginning) (region-end))))

(defun clojure-insert-last-result ()
  "TODO: Create this function.

Insert the last minibuffer message starting with \"=> \", starting at point"
  (interactive)
  nil)

(setq cider-debug-break-toggled nil)
(defun cider-toggle-debug-break-fn ()
  (interactive)
  (if cider-debug-break-toggled
      (progn
        (setq cider-debug-break-toggled 't)
        (cider-enable-debug-break-fn))
    (progn
      (setq cider-debug-break-toggled nil)
      (cider-disable-debug-break-fn))))

(defun cider-enable-debug-break-fn ()
  (interactive)
  (let ((current (current-buffer)))
    (save-excursion
      (find-file "~/.lein/break_stuff.clj")
      (beginning-of-buffer)
      (cider-eval-defun-at-point)
      (next-line)
      (cider-debug-defun-at-point)
      (switch-to-buffer current))))

(defun cider-disable-debug-break-fn ()
  (interactive)
  (let ((current (current-buffer)))
    (save-excursion
      (find-file "~/.lein/break_stuff.clj")
      (beginning-of-buffer)
      (cider-eval-defun-at-point)
      (next-line)
      (cider-eval-defun-at-point)
      (switch-to-buffer current))))
