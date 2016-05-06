(setq my-virtualenvwrapper-packages
      '(virtualenvwrapper))

(defun my-virtualenvwrapper/init-virtualenvwrapper ()
  (require 'virtualenvwrapper)
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell)             ;; if you want eshell support
  (setq venv-location "~/.virtualenvs/"))
