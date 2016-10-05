(setq my-party-mode-packages
      '(emms
        (party-mode :location (recipe
                               :fetcher github
                               :repo "parkeristyping/party-mode"
                               :files ("party-mode.el" "music")))))

(defun my-party-mode/init-emms ()
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)

  (require 'emms-player-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd)
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6600"))

(defun my-party-mode/init-party-mode ()
  (require 'party-mode))
