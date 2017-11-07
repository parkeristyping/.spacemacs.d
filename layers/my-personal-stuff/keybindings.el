;; rebind avy
(evil-leader/set-key "SPC" 'evil-avy-goto-char)

;; set custom "own" bindings
(spacemacs/declare-prefix "o" "own")
(spacemacs/declare-prefix "od" "dired")
(spacemacs/set-leader-keys
  "ode" 'editable-dired
  "odj" 'dired-jump-other-window
  "odo" 'browse-url-of-dired-file
  "odu" 'dired-up-directory)
(spacemacs/declare-prefix "ob" "buffer/bundler")
(spacemacs/set-leader-keys
  "obi" 'indent-buffer
  "obo" 'bundle-open
  "obc" 'clean-buffer-list)
(spacemacs/declare-prefix "om" "monitor")
(spacemacs/set-leader-keys
  "ome" 'external-monitor
  "oml" 'laptop-monitor)
(spacemacs/declare-prefix "of" "flycheck")
(spacemacs/set-leader-keys "oft" 'toggle-flycheck-level)
(spacemacs/declare-prefix "oo" "org")
(spacemacs/set-leader-keys
  "oop" 'org-present
  "oop" 'org-present)
(spacemacs/declare-prefix "ow" "web")
(spacemacs/set-leader-keys
  "oww" 'wikt
  "owo" 'browse-url-default-macosx-browser)

;; windows
(spacemacs/declare-prefix "wg" "grab")
(spacemacs/set-leader-keys
  "wgh" 'grab-window-left
  "wgj" 'grab-window-down
  "wgk" 'grab-window-up
  "wgl" 'grab-window-right)
(spacemacs/declare-prefix "wp" "push/popup")
(spacemacs/set-leader-keys
  "wph" 'push-window-left
  "wpH" 'push-window-left-and-focus
  "wpj" 'push-window-down
  "wpJ" 'push-window-down-and-focus
  "wpk" 'push-window-up
  "wpK" 'push-window-up-and-focus
  "wpl" 'push-window-right
  "wpL" 'push-window-right-and-focus)

;; sql mode rebindings
(spacemacs/declare-prefix-for-mode 'sql-mode
  "e" "evaluation")
(spacemacs/set-leader-keys-for-major-mode 'sql-mode
  "ef" 'sql-send-paragraph
  "er" 'sql-send-region
  "eb" 'sql-send-buffer)

;; helm rebindings
(spacemacs/set-leader-keys
  "saa" 'helm-do-ag-this-file)

(spacemacs/set-leader-keys
  "sah" 'my-helm-do-ag-home)

(spacemacs/set-leader-keys
  "hf" 'helm-projectile-find-file-in-known-projects)
