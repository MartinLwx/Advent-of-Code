(require '[clojure.java.io :as io])

(defn line->delta [line]
  (let [v (Integer/parseInt (subs line 1))]
    (case (.charAt line 0)
      \L (- v)
      \R v)))

(defn count-click [start delta]
  (let [end (mod (+ start delta) 100)
        cycle (quot (abs delta) 100)]
    (+ cycle
       (if (not (zero? start))
         (if (or (and (pos? delta) (< end start))
                 (and (neg? delta) (< start end)))
           1
           (if (zero? end) 1 0))
         0))))

(with-open [f (io/reader "./input.txt")]
  (->> (line-seq f)
       (map line->delta)
       (reduce
        (fn [{:keys [pos cnt]} delta]
          (let [pos' (mod (+ pos delta) 100)]
            {:pos pos'
             :cnt (+ cnt
                     (count-click pos delta))}))
        {:pos 50 :cnt 0})
       :cnt
       prn))

