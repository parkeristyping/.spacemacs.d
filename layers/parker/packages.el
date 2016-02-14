(setq parker-packages
      '(
        emms
        (party-mode :location (recipe
                               :fetcher github
                               :repo "parkeristyping/party-mode"))
        ))

(defun parker/init-emms ()
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)

  (require 'emms-player-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd)
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6600"))

(defun parker/init-party-mode ()
  (require 'party-mode))
