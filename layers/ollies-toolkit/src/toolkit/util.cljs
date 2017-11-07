(ns toolkit.util
  (:require [clojure.walk :refer [postwalk]]))

(defn- update-keys
  "Recursively transforms all map keys using f."
  [m f]
  (let [kf (fn [[k v]] [(f k) v])]
    (postwalk (fn [x] (if (map? x) (into {} (map kf x)) x)) m)))
