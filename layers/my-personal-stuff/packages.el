(setq my-personal-stuff-packages
      '(evil
        clojure-mode
        sql-mode
        org-mode
        ruby-mode
        python-mode
        clojure-mode
        keychain-environment))

(defun my-personal-stuff/post-init-ruby-mode ()
  ;; treat "_" as word char
  (add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w"))))

(defun my-personal-stuff/post-init-python-mode ()
  ;; treat "_" as word char
  (add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w"))))

(defun my-personal-stuff/post-init-js2-mode ()
  ;; treat "_" as word char
  (add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w"))))

(defun my-personal-stuff/post-init-clojure-mode ()
  (use-package clojure-mode
    :defer t
    :config
    (progn
      ;; fix indentation for Compojure macros
      (define-clojure-indent
        (defroutes 'defun)
        (GET 2)
        (POST 2)
        (PUT 2)
        (DELETE 2)
        (HEAD 2)
        (ANY 2)
        (context 2))
      ;; Count "-" as a word character
      (add-hook 'clojure-mode-hook
                #'(lambda () (modify-syntax-entry ?- "w"))))))

(defun my-personal-stuff/post-init-sql-mode ()
  (progn
    (add-hook 'sql-interactive-mode-hook
              (lambda ()
                (toggle-truncate-lines t)))
    (add-hook 'sql-mode-hook
              (lambda ()
                (sql-set-product 'postgres)))
    (add-hook 'sql-interactive-mode-hook
              'my-sql-interactive-mode-hook)))

(defun my-personal-stuff/post-init-org-mode ()
  (progn
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((scheme . t)
       (ruby . t)
       (python . t)
       (js . t)))))

(defun my-personal-stuff/post-init-evil ()
  (define-key evil-normal-state-map (kbd "RET")
    (lambda () (interactive) (evil-insert-newline-below))))

(defun my-personal-stuff/init-keychain-environment ()
  (use-package keychain-environment
    :config
    (keychain-refresh-environment)))
