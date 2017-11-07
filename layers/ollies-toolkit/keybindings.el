(spacemacs/declare-prefix "oj" "json")
(spacemacs/set-leader-keys
  "ojj" 'ollies-toolkit-edn->json
  "ojf" 'ollies-toolkit-format-json
  "oje" 'ollies-toolkit-json->edn
  "ojd" 'ollies-toolkit-format-edn)
