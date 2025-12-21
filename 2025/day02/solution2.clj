(require '[clojure.string :as str])

(defn invalid?
  "Check if a digit is invalid"
  [n]
  (let [n_str (str n)
        n_str_len (count n_str)
        choices (->> (range 1 (inc (quot n_str_len 2)))
                     (filter #(zero? (mod n_str_len %)))
                     (filter #(>= (quot n_str_len %) 2)))]
    (reduce
     (fn [acc x]
       (or acc
           (= n_str
              (str/join (repeat (quot n_str_len x)
                                (subs n_str 0 x))))))
     false
     choices)))

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
