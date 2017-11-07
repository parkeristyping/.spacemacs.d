(setq my-party-mode-packages
      '((party-mode :location
                    (recipe :fetcher github
                            :repo "parkeristyping/party-mode"
                            :files ("party-mode.el")))))

(defun my-party-mode/init-party-mode ()
  (use-package party-mode
    :config
    (progn
      (setq party-mode-start-music-fn
            (lambda () (start-process "party-music" "*party-music*" "afplay" party-mode-music-path)))
      (setq party-mode-stop-music-fn
            (lambda () (kill-process "party-music"))))))
