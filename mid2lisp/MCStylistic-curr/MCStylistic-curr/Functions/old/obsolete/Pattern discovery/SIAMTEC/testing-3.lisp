

(setq origin
      (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1) SIA"))
(setq destination
      (concatenate
  'string
  "//Applications/CCL/Lisp documentation/Pattern"
  " discovery/Example files/Fantasia (1 1)"
  " translations"))
(setq partition-origin 50)
(setq partition-destination 5)
(setq number-of-files 2)
(setq counter-origin 1)
(setq counter-destination 1)
(setq growing-list nil)
(setq j 0)
(setq vector-MTP-pairs
         (if (<= counter-origin number-of-files)
           (read-from-file
            (concatenate
             'string
             origin " "
             (write-to-string counter-origin)
             ".txt"))))
(setq pattern (cdr (first vector-MTP-pairs)))
(setq result-recent
         (assoc pattern growing-list
                :test #'test-translation))
(setq result
         (if (and (> counter-destination 1)
                  (null result-recent))
           (assoc-files
            pattern growing-list
            (- counter-destination 1))
           (identity result-recent)))

(setq growing-list
      (append
            growing-list
            (list (list pattern))))
(setq j (+ j 1))
(setq vector-MTP-pairs (rest vector-MTP-pairs))




