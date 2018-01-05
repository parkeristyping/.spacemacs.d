;; For some actions, I want to automatically add the new buffers to the current layout

;; First, let's add cider REPL buffers
(defun add-latest-repl-buffer-to-persp ()
  (let* (;; get names of each buffer
         (bufs (mapcar (function buffer-name) (buffer-list)))
         ;; filter to just those that are cider repls
         (repl-bufs (seq-filter (lambda (s) (string-match "cider-repl" s)) bufs))
         ;; select the last one, which happens to always (?) be the most recent
         (latest-repl-buf (car (last repl-bufs))))
    (persp-add-buffer latest-repl-buf (get-current-persp) nil)))

(add-hook 'cider-connected-hook 'add-latest-repl-buffer-to-persp)

;; Next, let's add *SQL* buffers
(defun add-latest-sql-buffer-to-persp ()
  (let* (;; get names of each buffer
         (bufs (mapcar (function buffer-name) (buffer-list)))
         ;; filter to just those that are sql buffers
         (sql-bufs (seq-filter (lambda (s) (string-match "*SQL" s)) bufs))
         ;; select the last one, which happens to always (?) be the most recent
         (latest-sql-buf (car (last sql-bufs))))
    (persp-add-buffer latest-sql-buf (get-current-persp) nil)))

(add-hook 'sql-interactive-mode-hook 'add-latest-sql-buffer-to-persp)
