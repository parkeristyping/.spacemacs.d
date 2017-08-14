(ns clomacs-fns.convert
  (:require [camel-snake-kebab.core :refer [->kebab-case ->camelCase ->PascalCase ->snake_case]]
            [cheshire.core :as json]
            [clojure.pprint :refer [pprint]]
            [clojure.string :as cs]
            [clojure.walk :refer [postwalk stringify-keys keywordize-keys]]))

(defn update-keys
  "Recursively transforms all map keys using f."
  [m f]
  (let [kf (fn [[k v]] [(f k) v])]
    (postwalk (fn [x] (if (map? x) (into {} (map kf x)) x)) m)))

(defn- kebab-keys
  [m]
  (update-keys m ->kebab-case))

(defn- camel-keys
  [m]
  (update-keys m ->camelCase))

(defn- pascal-keys
  [m]
  (update-keys m ->PascalCase))

(defn- snake-keys
  [m]
  (update-keys m ->snake_case))

(defn wrap-str
  [s]
  (format "\"%s\"" s))

(defn read-json
  [s]
  (json/parse-string s))

(defn read-edn
  [s]
  (read-string s))

(def pprinter (json/create-pretty-printer
                (assoc json/default-pretty-print-options
                  :before-array-values ""
                  :after-array-values ""
                  :object-field-value-separator ": ")))

(defn ->json-str
  [d]
  (json/generate-string d {:pretty pprinter}))

(defn ->edn-str
  [d]
  (cs/replace (with-out-str (pprint d)) #",\n" "\n"))

(def arg-map
  {"none" identity
   "camel" camel-keys
   "kebab" kebab-keys
   "pascal" pascal-keys
   "snake" snake-keys
   "stringify" stringify-keys
   "keywordize" keywordize-keys})

(defn- mk-trans
  [opts]
  (apply comp (map #(get arg-map %) (or opts []))))

(defn json->edn
  [s & opts]
  (-> (read-json s)
      ((mk-trans opts))
      ->edn-str))

(defn edn->json
  [s & opts]
  (-> (read-edn s)
      ((mk-trans opts))
      ->json-str))
