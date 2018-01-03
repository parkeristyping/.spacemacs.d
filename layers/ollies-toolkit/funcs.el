;; NOTE: This only works when the file is loaded - re-evaluating here will break things.
(setq ollies-toolkit-src-dir
      (concat (file-name-directory load-file-name) "src"))

(setq ollies-toolkit-planck-cmd
      (concat (format "planck -c %s" ollies-toolkit-src-dir)
              " -e '(require (quote toolkit.core))'"
              " -e '(toolkit.core/process %s)'"
              " | sed 's/^.\(.*\).$/\1/'"))

(defun ollies-toolkit-run-cljs-command (action beg end)
  (let ((cmd (format
              ollies-toolkit-planck-cmd
              action)))
    (write-region beg end "/tmp/cljs-data.txt")
  (shell-command-on-region beg end cmd 't 't)))

(defun ollies-toolkit-json->edn (beg end)
  (interactive "r")
  (save-excursion
    (let* ((tc (completing-read "type convert: " '("none" "stringify" "keywordize") nil t nil nil "keywordize"))
           (cc (completing-read "case convert: " '("none" "camel" "kebab" "pascal" "snake") nil t nil nil "kebab")))
      (ollies-toolkit-run-cljs-command (format ":json->edn :%s :%s" tc cc) beg end))))

(defun ollies-toolkit-format-edn (beg end)
  (interactive "r")
  (save-excursion
    (let* ((tc (completing-read "type convert: " '("none" "stringify" "keywordize") nil t nil nil "keywordize"))
           (cc (completing-read "case convert: " '("none" "camel" "kebab" "pascal" "snake") nil t nil nil "kebab")))
      (ollies-toolkit-run-cljs-command (format ":format-edn :%s :%s" tc cc) beg end))))

(defun ollies-toolkit-format-json (beg end)
  (interactive "r")
  (save-excursion
    (let* ((cc (completing-read "case convert: " '("none" "camel" "kebab" "pascal" "snake") nil t nil nil "camel")))
      (ollies-toolkit-run-cljs-command (format ":format-json :%s" cc) beg end))))

(defun ollies-toolkit-edn->json (beg end)
  (interactive "r")
  (save-excursion
    (let* ((cc (completing-read "case convert: " '("none" "camel" "kebab" "pascal" "snake") nil t nil nil "camel")))
      (ollies-toolkit-run-cljs-command (format ":edn->json :%s" cc) beg end))))
