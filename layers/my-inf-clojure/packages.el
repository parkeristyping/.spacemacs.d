(setq my-inf-clojure-packages
      '(inf-clojure))

(defun my-inf-clojure/init-inf-clojure ()
  (use-package inf-clojure
    :config
    (progn
      (setq inf-clojure-generic-cmd "planck")
      (add-hook 'inf-clojure-minor-mode
                (lambda () (cider-mode -1))))))
