(ns clomacs-fns.core
  (:require [clojure.data.json :as json]))

(defn to-json
  [d]
  (with-out-str
    (json/pprint d)))

(defn edn->json
  [s]
  (let [edn (read-string s)]
    (to-json edn)))

(defn add-4
  [x]
  (+ 4 x))
