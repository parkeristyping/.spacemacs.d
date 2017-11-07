(ns toolkit.convert
  (:require [cljs.reader :refer [read-string]]
            [clojure.string :as cs]
            [clojure.walk :refer [stringify-keys keywordize-keys]]
            [cognitect.transit :as t]
            [fipp.clojure :refer [pprint]]
            [toolkit.csk :as csk]
            [toolkit.util :refer [update-keys]]))

(defn- mk-key-fn
  [f]
  (fn [m] (update-keys m f)))

(def camel-keys (mk-key-fn csk/->camelCase))
(def pascal-keys (mk-key-fn csk/->PascalCase))
(def snake-keys (mk-key-fn csk/->snake_case))
(def kebab-keys (mk-key-fn csk/->kebab-case))

(defn- read-json
  [s]
  (t/read (t/reader :json) s))

(defn- read-edn
  [s]
  (read-string s))

(defn- ->json-str
  [d]
  (.stringify js/JSON (clj->js d) nil 2))

(defn- ->edn-str
  [d]
  (cs/trimr
    (cs/replace (with-out-str (pprint d)) #",\n" "\n")))

(def ^:private arg-map
  {:none identity
   :camel camel-keys
   :kebab kebab-keys
   :pascal pascal-keys
   :snake snake-keys
   :stringify stringify-keys
   :keywordize keywordize-keys})

(defn- mk-reader
  [k]
  (case k
    :json read-json
    :edn read-edn))

(defn- mk-writer
  [k]
  (case k
    :json ->json-str
    :edn ->edn-str))

(defn- mk-trans
  [in out]
  (let [read (mk-reader in)
        write (mk-writer out)]
    (fn [s & opts]
      (-> (read s)
          ((apply comp (map #(get arg-map %) (or opts []))))
          (write)))))

(def json->edn (mk-trans :json :edn))
(def format-edn (mk-trans :edn :edn))
(def edn->json (mk-trans :edn :json))
(def format-json (mk-trans :json :json))
