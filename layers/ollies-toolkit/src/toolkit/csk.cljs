(ns toolkit.csk
  "Lightweight clone of a few fns from camel-snake-kebab. Probably not as fast / robust,
  but seem to do alright and this works in Planck."
  (:require [clojure.string :as cs]))

(defn- classify-char [c]
  (case c
    (\0 \1 \2 \3 \4 \5 \6 \7 \8 \9) :number
    (\- \_ \space \tab \newline \o013 \formfeed \return) :whitespace
    (\a \b \c \d \e \f \g \h \i \j \k \l \m \n \o \p \q \r \s \t \u \v \w \x \y \z) :lower
    (\A \B \C \D \E \F \G \H \I \J \K \L \M \N \O \P \Q \R \S \T \U \V \W \X \Y \Z) :upper
    :other))

(defn- split-str
  [s]
  (loop [res [[]], lc nil, rem s]
    (if (seq rem)
      (let [c (first rem)
            nc (classify-char c)
            nres (cond
                   (= :whitespace nc) (conj res [])
                   (and
                     (= :upper nc)
                     (= :lower lc)) (conj res [c])
                   :else (conj (pop res) (conj (peek res) c)))]
        (recur nres nc (rest rem)))
      (map cs/join (remove empty? res)))))

(defn- ->str
  [sok]
  (if (keyword? sok)
    (subs (str sok) 1)
    sok))

(defn- mk-conversion
  [first-fn rest-fn sep]
  (fn [sok]
    (let [k? (keyword? sok)
          s (->str sok)
          res (cs/join sep
                (map
                  #(%2 %1)
                  (split-str s)
                  (conj (repeat rest-fn) first-fn)))]
      (if k?
        (keyword res)
        res))))

(def ->PascalCase (mk-conversion cs/capitalize cs/capitalize ""))
(def ->camelCase (mk-conversion cs/lower-case cs/capitalize ""))
(def ->kebab-case (mk-conversion cs/lower-case cs/lower-case "-"))
(def ->snake_case (mk-conversion cs/lower-case cs/lower-case "_"))
