(setq my-personal-stuff-packages
      '(evil
        clojure-mode
        keychain-environment))

(defun my-personal-stuff/post-init-clojure-mode ()
  (use-package clojure-mode
    :defer t
    :config
    (progn
      ;; fix indentation for Compojure macros
      (define-clojure-indent
        (-> 0)
        (->> 0)
        (some-> 0)
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

(defun my-personal-stuff/post-init-evil ()
  (define-key evil-normal-state-map (kbd "RET")
    (lambda () (interactive) (evil-insert-newline-below))))

(defun my-personal-stuff/init-keychain-environment ()
  (use-package keychain-environment
    :config
    (keychain-refresh-environment)))
