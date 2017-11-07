(setq my-inf-clojure-mode-active nil)

(defun my-inf-clojure-toggle-active ()
  (interactive)
  (if my-inf-clojure-mode-active
      (progn
        (setq my-inf-clojure-mode-active nil)
        (kill-buffer "*inf-clojure*")
        (dolist (m '(clojure-mode
                     clojurescript-mode))
          (spacemacs/set-leader-keys-for-major-mode m
            "ef" 'cider-eval-defun-at-point
            "er" 'cider-eval-region
            "sc" 'cider-connect
            "sq" 'cider-quit))
        (message "my inf-clojure mode disactivated"))
    (progn
      (inf-clojure-switch-to-repl 1)
      (setq my-inf-clojure-mode-active 't)
      (dolist (m '(clojure-mode
                   clojurescript-mode))
        (spacemacs/set-leader-keys-for-major-mode m
          "ef" 'inf-clojure-eval-defun
          "er" 'inf-clojure-eval-region
          "sc" 'inf-clojure-connect))
      (message "my inf-clojure mode actived"))))
