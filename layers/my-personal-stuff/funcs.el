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
