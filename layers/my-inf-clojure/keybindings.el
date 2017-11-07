;; Gracefully switch in / out of inf-clojure-mode
(spacemacs/declare-prefix "oc" "clojure")
(spacemacs/set-leader-keys "oci" 'my-inf-clojure-toggle-active)
