(setq parker-packages
      '(
        (tidal :location (recipe
                          :fetcher github
                          :repo "tidalcycles/Tidal"))
        ))

(defun tidal/init-tidal ()
  (require 'haskell-mode)
  (require 'tidal))
