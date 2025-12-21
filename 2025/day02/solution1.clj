(require '[clojure.string :as str])

(defn invalid?
  "Check if a digit is valid"
  [n]
  (let [n_str (str n)
        half-idx (quot (count n_str) 2)]
    (= (subs n_str 0 half-idx)
       (subs n_str half-idx))))

(defn get-invalid-ids
  "Find all invalid ids and returns as a collection"
  [r]
  (let [parts (str/split r #"-")
        lhs (Long/parseLong (first parts))
        rhs (Long/parseLong (second parts))]
    (->> (range lhs (inc rhs))
         (filter invalid?))))

(let [first-line (->> (slurp "input.txt")
                      str/split-lines
                      first)]
  (->> (str/split first-line #",")
       (mapcat get-invalid-ids)
       (reduce +)
       prn))
