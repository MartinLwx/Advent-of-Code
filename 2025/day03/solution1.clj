(require '[clojure.java.io :as io])

(defn find-largest-joltage
  [xs start-idx allow-last-digit]
  (let [sorted-xs-with-idx (->> (map-indexed vector xs)
                                (filter (fn [[idx _]] (>= idx start-idx)))
                                (sort-by second >))
        largest-pair (first sorted-xs-with-idx)]
    (if (= (first largest-pair) (dec (count xs)))
      (if allow-last-digit
        largest-pair
        (second sorted-xs-with-idx))
      largest-pair)))

(defn max-per-bank [bank]
  (let [[first-digit-idx first-digit] (find-largest-joltage bank 0 false)
        [_ second-digit] (find-largest-joltage bank (inc first-digit-idx) true)]
    (+ (* 10 first-digit)
       second-digit)))

(with-open [f (io/reader "input.txt")]
  (->> (line-seq f)
       (map (fn [line] (map #(Character/digit % 10) line)))
       (map max-per-bank)
       (reduce +)
       prn))
