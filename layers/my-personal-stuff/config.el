;; Load secrets, containing:
;; - SQL database connection details
(load (concat (file-name-directory load-file-name) "secrets.el"))

;; SQL stuff
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

;; Silence compiler warnings
(defvar sql-product)
(defvar sql-prompt-regexp)
(defvar sql-prompt-cont-regexp)

(add-hook 'sql-interactive-mode-hook 'my-sql-interactive-mode-hook)
(defun my-sql-interactive-mode-hook ()
  "Custom interactive SQL mode behaviours. See `sql-interactive-mode-hook'."
  (when (eq sql-product 'postgres)
    ;; Allow symbol chars in database names in prompt.
    (setq sql-prompt-regexp "^\\w*=[#>] ")
    (setq sql-prompt-cont-regexp "^\\w*[-(][#>] "))

  ;; Deal with inline prompts in query output.
  ;; Runs after `sql-interactive-remove-continuation-prompt'.
  (add-hook 'comint-preoutput-filter-functions
            'my-sql-comint-preoutput-filter :append :local))

(defun my-sql-comint-preoutput-filter (output)
  "Filter prompts out of SQL query output.

  Runs after `sql-interactive-remove-continuation-prompt' in
  `comint-preoutput-filter-functions'.

  BROKEN - FIX ME PLEASE"

  ;; If the entire output is simply the main prompt, return that.
  ;; (i.e. When simply typing RET at the sqli prompt.)
  (if (string-match (concat "\\`\\(" sql-prompt-regexp "\\)\\'") output)
      output
    ;; Otherwise filter all leading prompts from the output.
    ;; Store the buffer-local prompt patterns before changing buffers.
    (let ((main-prompt sql-prompt-regexp)
          (any-prompt comint-prompt-regexp) ;; see `sql-interactive-mode'
          (prefix-newline nil))
      (with-temp-buffer
        (insert output)
        (goto-char (point-min))
        (when (looking-at main-prompt)
          (setq prefix-newline t))
        (while (looking-at any-prompt)
          (replace-match ""))
        ;; Prepend a newline to the output, if necessary.
        (when prefix-newline
          (goto-char (point-min))
          (unless (looking-at "\n")
            (insert "\n")))
        ;; Return the filtered output.
        (buffer-substring-no-properties (point-min) (point-max))))))

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
;; (setq org-startup-truncated nil)

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
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((scheme . t)
     (ruby . t)
     (python . t)
     (js . t))))

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
