(defun indent-buffer ()
  "Indent the whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))

(defun editable-dired ()
  "Make dired editable"
  (interactive)
  (wdired-change-to-wdired-mode))

(defun external-screen ()
  "Toggle between font sizes for laptop and external monitor"
  (interactive)
  (set-face-attribute 'default nil :height 150))

(defun laptop-screen ()
  "Toggle between font sizes for laptop and external monitor"
  (interactive)
  (set-face-attribute 'default nil :height 120))
