(setq parker-packages
      '(
        emms
        (party-mode :location (recipe
                               :fetcher github
                               :repo "parkeristyping/party-mode"))

        persp-mode))

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

(defun parker/post-init-persp-mode ()
  ;; Fix layouts mode so it exits the micro-state after you switch
  ;; Define all `spacemacs/persp-switch-to-X' functions
  (dolist (i (number-sequence 9 0 -1))
    (eval `(defun ,(intern (format "spacemacs/persp-switch-to-%s" i)) nil
             ,(format "Switch to layout %s." i)
             (interactive)
             (spacemacs/layout-switch-by-pos ,(if (eq 0 i) 9 (1- i))))))

  (defun spacemacs/jump-to-last-layout ()
    "Open the previously selected layout, if it exists."
    (interactive)
    (unless (eq 'non-existent
                (gethash spacemacs--last-selected-layout
                         *persp-hash* 'non-existent))
          (persp-switch spacemacs--last-selected-layout)
          ;; lol I actually have to mimic a keypress to exit the micro-state
          ;; there must be a better way, but this works
          (setq unread-command-events (listify-key-sequence "\C-g")))))
