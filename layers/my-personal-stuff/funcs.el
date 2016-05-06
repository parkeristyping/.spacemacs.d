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

(defun toggle-flycheck-level ()
  "Toggle between lighter and higher frequency syntax checking"
  (interactive)
  (if (equal flycheck-check-syntax-automatically '(save))
      (setq flycheck-check-syntax-automatically '(save idle-change))
    (setq flycheck-check-syntax-automatically '(save)))
  (message (concat "Flycheck automatic syntax checking updated to " (format "%s" flycheck-check-syntax-automatically))))
