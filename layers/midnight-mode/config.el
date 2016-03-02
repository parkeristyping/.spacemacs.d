;; Use midnight mode to kill unused buffers
(require 'midnight)

;; Set inactivity period after which to kill buffers
(setq clean-buffer-list-delay-special 900) ;; 15 min

;; Set midnight period to 1 hour.
(setq midnight-period 3600) ;; 1 hour

;; Set what to kill (everything)
(setq clean-buffer-list-kill-regexps '("^.*$"))

;; Set what not to kill
(setq clean-buffer-list-kill-never-buffer-names
      '("*Messages*"
        "*cmd*"
        "*scratch*"))
