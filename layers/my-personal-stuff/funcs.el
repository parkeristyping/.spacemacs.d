;; Silence compiler warnings
(defvar sql-product)
(defvar sql-prompt-regexp)
(defvar sql-prompt-cont-regexp)

(defun my-sql-interactive-mode-hook ()
  "Custom interactive SQL mode behaviours. See `sql-interactive-mode-hook'."
  (when (eq sql-product 'postgres)
    ;; Allow symbol chars in database names in prompt.
    ;; Default postgres pattern was: "^\\w*=[#>] " (see `sql-product-alist').
    (setq sql-prompt-regexp "^\\(?:\\sw\\|\\s_\\)*=[#>] ")
    ;; Ditto for continuation prompt: "^\\w*[-(][#>] "
    (setq sql-prompt-cont-regexp "^\\(?:\\sw\\|\\s_\\)*[-(][#>] "))

  ;; Deal with inline prompts in query output.
  ;; Runs after `sql-interactive-remove-continuation-prompt'.
  (add-hook 'comint-preoutput-filter-functions
            'my-sql-comint-preoutput-filter :append :local))

(defun my-sql-comint-preoutput-filter (output)
  "Filter prompts out of SQL query output.

Runs after `sql-interactive-remove-continuation-prompt' in
`comint-preoutput-filter-functions'."
  ;; If the entire output is simply the main prompt, return that.
  ;; (i.e. When simply typing RET at the sqli prompt.)
  (if (string-match (concat "\\`\\(" sql-prompt-regexp "\\)\\'") output)
      output
    ;; Otherwise filter all leading prompts from the output.
    ;; Store the buffer-local prompt patterns before changing buffers.
    (let ((main-prompt sql-prompt-regexp)
          (any-prompt comint-prompt-regexp) ;; see `sql-interactive-mode'
          (prefix-newline nil))
      (with-temp-buffer
        (insert output)
        (goto-char (point-min))
        (when (looking-at main-prompt)
          (setq prefix-newline t))
        (while (looking-at any-prompt)
          (replace-match ""))
        ;; Prepend a newline to the output, if necessary.
        (when prefix-newline
          (goto-char (point-min))
          (unless (looking-at "\n")
            (insert "\n")))
        ;; Return the filtered output.
        (buffer-substring-no-properties (point-min) (point-max))))))

(defadvice sql-send-string (before my-prefix-newline-to-sql-string)
  "Force all `sql-send-*' commands to include an initial newline.

This is a trivial solution to single-line queries tripping up my
custom output filter.  (See `my-sql-comint-preoutput-filter'.)"
  (ad-set-arg 0 (concat "\n" (ad-get-arg 0))))
(ad-activate 'sql-send-string)

(defun kill-pg-connections-cmd-string (db)
  (interactive "MDatabase: ")
  (insert
   (format "SELECT pg_terminate_backend(pg_stat_activity.pid)
            FROM pg_stat_activity
            WHERE pg_stat_activity.datname = '%s'
            AND pid <> pg_backend_pid();"
           db)))

(defun indent-buffer ()
  "Indent the whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))

(defun editable-dired ()
  "Make dired editable"
  (interactive)
  (wdired-change-to-wdired-mode))

(defun external-monitor ()
  "Toggle between font sizes for laptop and external monitor"
  (interactive)
  (set-face-attribute 'default nil :height 180))

(defun laptop-monitor ()
  "Toggle between font sizes for laptop and external monitor"
  (interactive)
  (set-face-attribute 'default nil :height 125))

(defun big-screen ()
  "Toggle between font sizes for laptop and external monitor"
  (interactive)
  (set-face-attribute 'default nil :height 200))

(defun toggle-flycheck-level ()
  "Toggle between lighter and higher frequency syntax checking"
  (interactive)
  (if (equal flycheck-check-syntax-automatically '(save))
      (setq flycheck-check-syntax-automatically '(save idle-change))
    (setq flycheck-check-syntax-automatically '(save)))
  (message (concat "Flycheck automatic syntax checking updated to " (format "%s" flycheck-check-syntax-automatically))))

(defun push-window-dir (dir)
  (let ((win (windmove-find-other-window dir)))
    (set-window-buffer win (current-buffer))))

;; TODO refactor these
(defun push-window-left ()
  (interactive)
  (push-window-dir 'left))

(defun push-window-left-and-focus ()
  (interactive)
  (push-window-dir 'left)
  (windmove-left))

(defun push-window-right ()
  (interactive)
  (push-window-dir 'right))

(defun push-window-right-and-focus ()
  (interactive)
  (push-window-dir 'right)
  (windmove-right))

(defun push-window-down ()
  (interactive)
  (push-window-dir 'below))

(defun push-window-down-and-focus ()
  (interactive)
  (push-window-dir 'below)
  (windmove-down))

(defun push-window-up ()
  (interactive)
  (push-window-dir 'above))

(defun push-window-up-and-focus ()
  (interactive)
  (push-window-dir 'above)
  (windmove-up))

(defun grab-window-dir (dir)
  (let ((other-window (windmove-find-other-window dir)))
    (if other-window
        (set-window-buffer nil (window-buffer other-window)))))

;; TODO refactor these
(defun grab-window-left ()
  (interactive)
  (grab-window-dir 'left))

(defun grab-window-right ()
  (interactive)
  (grab-window-dir 'right))

(defun grab-window-up ()
  (interactive)
  (grab-window-dir 'above))

(defun grab-window-down ()
  (interactive)
  (grab-window-dir 'below))

;; Helm stuff
(defun my-helm-do-ag-home ()
  (interactive)
  (helm-do-ag "/Users/plawrence/gr/"))

;; Thanks, Alex ter Weele
(defun wikt (beg end)
  "Wiktionary lookup"
  (interactive "r")
  (let ((word (if (use-region-p)
                  (buffer-substring-no-properties beg end)
                (thing-at-point 'word t))))
    (browse-url
     (format "https://en.wiktionary.org/wiki/%s" word))))

;; Rotate indent.
;; Indentation rules are a PITA. This is a function that will rotate
;; through some common settings and hopefully match whatever file I'm
;; in to prevent messy commits
(setq my-web-indent-levels '(4 2))
(defun rotate-web-indent ()
  (interactive)
  (let ((n (car my-web-indent-levels))
        (updated (-snoc (cdr my-web-indent-levels) (car my-web-indent-levels))))

    (setq my-web-indent-levels updated)

    ;; Set the vars
    (setq js2-basic-offset n)
    (setq web-mode-code-indent-offset n)
    (setq web-mode-markup-indent-offset n)
    (setq web-mode-css-indent-offset n)
    (setq css-indent-offset n)
    (setq js-indent-level n)

    (message (format "updated web indent levels: %s" n))))
