(dolist (m '(clojure-mode
             clojurec-mode
             clojurescript-mode
             clojurex-mode
             cider-repl-mode
             cider-clojure-interaction-mode))
  (spacemacs/set-leader-keys-for-major-mode m
    "gt" 'clojure-jump-to-or-from-tests
    "gT" 'clojure-jump-to-or-from-test-at-point
    "if" 'clojure-indent-defun-at-point
    "ir" 'clojure-indent-region
    "sz" 'cider-scratch
    "sd" 'cider-toggle-debug-break-fn))
