(require 'clomacs)

(clomacs-defun add-4-wrapper
               clomacs-fns.core/add-4
               :lib-name "clomacs-fns"
               :namespace clomacs-fns.core
               :doc "Example function")

(clomacs-defun edn->json-wrapper
               clomacs-fns.core/edn->json
               :lib-name "clomacs-fns"
               :namespace clomacs-fns.core
               :doc "Convert EDN to JSON")

(defun add-4 (n)
  (interactive "n")
  (message (format "%s" (add-4-wrapper n))))

(defun edn-region-to-json (beg end)
  (interactive "r")
  (message (format "%s" (buffer-substring beg end))))
  ;; (save-excursion
  ;;   ;; (message (format "%s %s" (point) (mark)))
  ;;   (let ((formatted (edn->json-wrapper (buffer-substring beg end))))
  ;;     (delete-region beg end)
  ;;     (

(provide 'clomacs-fns)
