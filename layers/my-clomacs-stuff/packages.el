(setq my-clomacs-stuff-packages
      '(clomacs))

(defun my-clomacs-stuff/init-clomacs ()
  (use-package clomacs)
  (add-to-list 'load-path "~/.spacemacs.d/layers/my-clomacs-stuff/clomacs-fns/src/elisp")
  (require 'clomacs-fns))
