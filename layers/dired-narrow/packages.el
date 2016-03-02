(setq dired-narrow-packages
      '(
        (dired-narrow :location (recipe
                                 :fetcher github
                                 :repo "Fuco1/dired-hacks"
                                 :files ("dired-narrow.el")))))

(defun dired-narrow/init-dired-narrow ()
  (use-package dired-narrow
    :ensure t
    :bind (:map dired-mode-map
                ("/" . dired-narrow))))
