(require '[clojure.java.io :as io])

(defn max-per-bank [bank]
  (let [k (- (count bank) 12)
        [stack k-left] (reduce
                        (fn [[stk k] digit]
                          (loop [stk stk
                                 k k]
                            (if (and (pos? k)
                                     (seq stk)
                                     (< (peek stk) digit))
                              (recur (pop stk) (dec k))
                              [(conj stk digit) k])))
                        [[] k]
                        bank)
        final-stack (loop [stk stack
                           k k-left]
                      (if (and (pos? k)
                               (seq stk))
                        (recur (pop stk) (dec k))
                        stk))]
    (->> final-stack
         (apply str)
         Long/parseLong)))

(with-open [f (io/reader "input.txt")]
  (->> (line-seq f)
       (map (fn [line] (map #(Character/digit % 10) line)))
       (map max-per-bank)
       (reduce +)
       prn))
