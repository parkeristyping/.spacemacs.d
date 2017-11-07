(ns toolkit.core
  (:require [planck.core :refer [slurp]] ;; DANGER: Planck dependency!
            [toolkit.convert :refer [json->edn format-edn edn->json format-json]]))

(def ^:private actions
  {:json->edn json->edn
   :format-edn format-edn
   :edn->json edn->json
   :format-json format-json})

(defn process
  [& args*]
  (let [s (slurp "/tmp/cljs-data.txt")
        act (first args*)
        args (rest args*)]
    (cond
      (not (contains? actions act)) (throw (js/Error. (str "Invalid action " act)))
      :else (print (apply (get actions act) s args)))))
