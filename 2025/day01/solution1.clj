(require '[clojure.java.io :as io])

(defn line->delta [line]
  (let [v (Integer/parseInt (subs line 1))]
    (case (.charAt line 0)
      \L (- v)
      \R v)))

(with-open [f (io/reader "./input.txt")]
  (->> (line-seq f)
       (map line->delta)
       (reduce
        (fn [{:keys [pos cnt history]} delta]
          (let [pos' (mod (+ pos delta 100) 100)]
            {:pos pos'
             :cnt (if (zero? pos') (inc cnt) cnt)
             :history (conj history pos')}))
        {:pos 50 :cnt 0 :history [50]})
       :cnt
       prn))
