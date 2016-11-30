(ns sql-formatter.core
  (:require [clojure.string :as str])
  (:gen-class))

(defn -main [filename]
  (let [sql (slurp filename)
        formatted1 (.format (org.hibernate.engine.jdbc.internal.BasicFormatterImpl.) sql)
        formatted2 (->> (str/split-lines formatted1)
                         (remove str/blank?)
                         (map str/trimr)
                         (map #(subs % 4))
                         (str/join "\n"))]
    (println formatted2)))
