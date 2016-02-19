;; newline without entering insert mode
(define-key evil-normal-state-map (kbd "RET") (lambda () (interactive) (evil-insert-newline-below)))

;; set prefixes
(spacemacs/declare-prefix "o" "own")
(spacemacs/declare-prefix "od" "dired")
(spacemacs/declare-prefix "os" "screen")

;; set custom leader bindings
(spacemacs/set-leader-keys "ode" 'editable-dired)
(spacemacs/set-leader-keys "bi" 'indent-buffer)
(spacemacs/set-leader-keys "ose" 'external-screen)
(spacemacs/set-leader-keys "osl" 'laptop-screen)
