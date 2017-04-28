(setq my-inf-clojure-packages
      '(inf-clojure))

(defun my-inf-clojure/init-inf-clojure ()
  (use-package inf-clojure)
  (setq inf-clojure-generic-cmd "planck"))
