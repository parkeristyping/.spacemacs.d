(setq my-tablature-mode-packages
      '((tablature-mode :location local)))

(defun my-tablature-mode/init-tablature-mode ()
  (load "~/.spacemacs.d/layers/my-tablature-mode/src/tablature-mode.el"))
