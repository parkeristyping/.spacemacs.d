;; editable dired
(global-set-key (kbd "M-a") (lambda () (interactive) (wdired-change-to-wdired-mode)))

;; indent whole buffer
(global-set-key (kbd "M-n") 'iwb)

;; easy buffer killing
(global-unset-key (kbd "M-k"))
(global-set-key (kbd "M-k") 'kill-this-buffer)
