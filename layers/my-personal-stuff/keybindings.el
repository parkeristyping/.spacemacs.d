;; newline without entering insert mode
(define-key evil-normal-state-map (kbd "RET") (lambda () (interactive) (evil-insert-newline-below)))

;; set prefixes
(spacemacs/declare-prefix "o" "own")
(spacemacs/declare-prefix "od" "dired")
(spacemacs/declare-prefix "om" "monitor")
(spacemacs/declare-prefix "ob" "buffer/bundler")
(spacemacs/declare-prefix "of" "flycheck")
(spacemacs/declare-prefix "oo" "org")

;; set custom leader bindings
(spacemacs/set-leader-keys "ode" 'editable-dired)
(spacemacs/set-leader-keys "odj" 'dired-jump-other-window)
(spacemacs/set-leader-keys "obi" 'indent-buffer)
(spacemacs/set-leader-keys "obo" 'bundle-open)
(spacemacs/set-leader-keys "obc" 'clean-buffer-list)
(spacemacs/set-leader-keys "ome" 'external-monitor)
(spacemacs/set-leader-keys "oml" 'laptop-monitor)
(spacemacs/set-leader-keys "oft" 'toggle-flycheck-level)
(spacemacs/set-leader-keys "oop" 'org-present)
