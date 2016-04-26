(setq parker-packages
      '(emms
        (party-mode :location (recipe
                               :fetcher github
                               :repo "parkeristyping/party-mode"))
        shell-pop
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

(defun parker/post-init-shell-pop ()
  (require 'shell-pop)

  (defun shell-pop--switch-to-shell-buffer-by-name (bufname)
    (if (get-buffer bufname)
        (switch-to-buffer bufname)
      (funcall (eval shell-pop-internal-mode-func))
      (rename-buffer bufname)
      (shell-pop--set-exit-action))
    (setq shell-pop-last-shell-buffer-name bufname))

  (defun shell-pop-up-by-name (bufname)
    (let ((index 0))
      (run-hooks 'shell-pop-in-hook)
      (let ((w (if (listp index)
                   (let ((ret (shell-pop-get-unused-internal-mode-buffer-window)))
                     (setq index (car ret))
                     (cdr ret))
                 (shell-pop-get-internal-mode-buffer-window index)))
            (cwd (replace-regexp-in-string "\\\\" "/" default-directory)))
        (when (shell-pop--full-p)
          (window-configuration-to-register :shell-pop)
          (delete-other-windows))
        (if w
            (select-window w)
          ;; save shell-pop-last-buffer and shell-pop-last-window to return
          (setq shell-pop-last-buffer (buffer-name)
                shell-pop-last-window (selected-window))
          (when (and (not (= shell-pop-window-height 100))
                     (not (shell-pop--full-p)))
            (let ((new-window (shell-pop-split-window)))
              (select-window new-window)))
          (when (and shell-pop-default-directory (file-directory-p shell-pop-default-directory))
            (cd shell-pop-default-directory))
          (shell-pop--switch-to-shell-buffer-by-name bufname))
        (when (and shell-pop-autocd-to-working-dir
                   (not (string= cwd default-directory)))
          (shell-pop--cd-to-cwd cwd))
        (run-hooks 'shell-pop-in-after-hook)))))

(defun parker/post-init-persp-mode ()
  (defun shell-pop-persp ()
    (interactive)
    (let ((shell-name (concat "*shell-" (spacemacs//current-layout-name) "*")))
      (if (string= (buffer-name) shell-name)
          (shell-pop-out)
        (progn
          (shell-pop-up-by-name shell-name)
          (persp-add-buffer (get-buffer shell-name))))))

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
