;; newline without entering insert mode
(define-key evil-normal-state-map (kbd "RET") (lambda () (interactive) (evil-insert-newline-below)))

;; set prefixes
(spacemacs/declare-prefix "o" "own")
(spacemacs/declare-prefix "od" "dired")
(spacemacs/declare-prefix "os" "screen")
(spacemacs/declare-prefix "ob" "buffer")

;; set custom leader bindings
(spacemacs/set-leader-keys "ode" 'editable-dired)
(spacemacs/set-leader-keys "obi" 'indent-buffer)
(spacemacs/set-leader-keys "ose" 'external-screen)
(spacemacs/set-leader-keys "osl" 'laptop-screen)
