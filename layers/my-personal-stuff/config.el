;; Load secrets, containing:
;; - SQL database connection details
(load (concat (file-name-directory load-file-name) "secrets.el"))

;; SQL stuff
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(add-hook 'sql-mode-hook
          (lambda ()
            (sql-set-product 'postgres)))

(defadvice sql-connect (around sql-connect-around activate)
  "SSH to linux, then connect"
  (let ((default-directory
          (if (string= connection 'lw-qa)
              "/ssh:mgmt:"
            default-directory)))
    ad-do-it))

;; Org mode stuff
(setq org-image-actual-width '(1000))
(setq org-startup-truncated nil)

;; javascript
(setq-default js2-basic-offset 2)

;; web mode
(setq-default web-mode-code-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq css-indent-offset 2)
(setq js-indent-level 2)

;; Specify program for multi-term
(setq multi-term-program "/bin/zsh")

;; Point to Eclipse for Java
(setq eclim-eclipse-dirs "/opt/homebrew-cask/Caskroom/eclipse-java/4.5.2/Eclipse.app/Contents/Eclipse"
      eclim-executable "/opt/homebrew-cask/Caskroom/eclipse-java/4.5.2/Eclipse.app/Contents/Eclipse/eclim")

;; Org Mode Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)
   (ruby . t)
   (python . t)
   (js . t)))

;; Include underscores in word motions
;; For python
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; For ruby
(add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; For Javascript
(add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; Open HTML files within hubspot_mirror project in Jinja2 mode
;; Not working so commented
;; (add-to-list 'auto-mode-alist '("*/hubspot_mirror/*" . jinja2-mode))

;; Change anaconda-mode port
(setq anaconda-mode-port 9001)
