;; Make the whole buffer pretty and consistent
(defun iwb ()
  "Indent Whole Buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))

;; Change font size for external screen
;; Note: C-x C-0 to return to default (i.e. for laptop)
(defun external-screen ()
  "Toggle between font sizes for laptop and external monitor"
  (interactive)
  (set-face-attribute 'default nil :height 150))

(defun laptop-screen ()
  "Toggle between font sizes for laptop and external monitor"
  (interactive)
  (set-face-attribute 'default nil :height 120))
