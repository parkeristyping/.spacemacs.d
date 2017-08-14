(spacemacs/declare-prefix "oc" "clomacs")
(spacemacs/set-leader-keys "ocs" 'start-clomacs)
(spacemacs/declare-prefix "oj" "json")
(spacemacs/set-leader-keys
  "ojj" 'edn->json-defaults
  "ojJ" 'edn->json
  "oje" 'json->edn-defaults
  "ojE" 'json->edn)
