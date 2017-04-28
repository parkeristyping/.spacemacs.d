;; set prefixes
(spacemacs/declare-prefix "oe" "eval")

;; set custom leader bindings
(spacemacs/set-leader-keys "oei" 'inf-clojure-minor-mode)
(spacemacs/set-leader-keys "oes" 'inf-clojure)
(spacemacs/set-leader-keys "oef" 'inf-clojure-eval-defun)
(spacemacs/set-leader-keys "oer" 'inf-clojure-eval-region)
