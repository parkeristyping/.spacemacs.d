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
  (set-face-attribute 'default nil :height 120))
