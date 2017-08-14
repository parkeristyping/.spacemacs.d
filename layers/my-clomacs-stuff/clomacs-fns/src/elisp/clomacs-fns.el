(require 'clomacs)

(clomacs-defun hello-clomacs
               clomacs-fns.core/hello
               :lib-name "clomacs-fns"
               :namespace clomacs-fns.core
               :doc "Function to start the Clojure process Clomacs will be using, without side-effects")

(clomacs-defun json->edn-wrapper
               clomacs-fns.convert/json->edn
               :lib-name "clomacs-fns"
               :namespace clomacs-fns.convert
               :doc "Convert JSON at point to EDN")

(clomacs-defun edn->json-wrapper
               clomacs-fns.convert/edn->json
               :lib-name "clomacs-fns"
               :namespace clomacs-fns.convert
               :doc "Convert EDN at point to JSON")

(defun start-clomacs ()
  (interactive)
  (message (hello-clomacs)))

(defun json->edn (beg end)
  (interactive "r")
  (save-excursion
    (let* ((tc (completing-read "Type Convert: " '("none" "stringify" "keywordize") nil t nil nil "keywordize"))
           (cc (completing-read "Case Convert: " '("none" "camel" "kebab" "pascal" "snake") nil t nil nil "kebab"))
           (res (json->edn-wrapper (buffer-substring beg end) tc cc)))
      (delete-region beg end)
      (insert res))))

(defun json->edn-defaults (beg end)
  (interactive "r")
  (save-excursion
    (let ((res (json->edn-wrapper (buffer-substring beg end) "keywordize" "kebab")))
      (delete-region beg end)
      (insert res))))

(defun edn->json (beg end)
  (interactive "r")
  (save-excursion
    (let* ((cc (completing-read "Case Convert: " '("none" "camel" "kebab" "pascal" "snake") nil t nil nil "camel"))
           (res (edn->json-wrapper (buffer-substring beg end) "stringify" cc)))
      (delete-region beg end)
      (insert res))))

(defun edn->json-defaults (beg end)
  (interactive "r")
  (save-excursion
    (let ((res (edn->json-wrapper (buffer-substring beg end) "stringify" "camel")))
      (delete-region beg end)
      (insert res))))

;; TODO:
;; - add format-json and format-edn variants, for formatting
;; - add json/edn auto-detection to reduce number of functions
;; - clean this up a bit so there's less repetition

(provide 'clomacs-fns)
