
(time
 (structural-induction-algorithm-r
  dataset-1-1-0-1-0 1
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 1 0 1 0) SIA_r.txt")))
; 0.125499 seconds (compared with 911.17900 secs!).

(progn
  (setq
   SIA-r-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) SIA_r.txt")))
  (time
   (compactness-trawler
    SIA-r-1-1-0-1-0 dataset-1-1-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) CT_r.txt")
    *compact-thresh* *cardina-thresh*)))
; took 0.157488 seconds.

(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L 1 analysis.lisp"))
(progn
  (setq
   SIA_rCT-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) CT_r.txt")))
  (time
   (setq
    hash-1-1-0-1-0
    (evaluate-variables-of-patterns2hash
     SIA_rCT-1-1-0-1-0 dataset-1-1-0-1-0))))
; 66.001330 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-1-0 hash-1-1-0-1-0 "pattern")
; TP = 1.
(length hash-1-1-0-1-0)
; TP + FP = 98.
(length targets-1-1-0-1-0)
; TP + TN = 8.


(progn
  (setq
   hash-orig
   (read-from-file-balanced-hash-table
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) hash.txt")))
  "Yes!")

---

(setq
 dataset
 '((0 60) (1 61) (2 62) (3 60) (5 60) (5 61) (6 59)
   (6 62) (7 60) (7 63) (8 61)))
(setq r 1)
(setq patterns
         (collect-by-cars
          (merge-sort-by
           (subtract&retain-at-fixed-distances
            dataset r))))
(setq growing-list nil)
(setq pattern (cdr (first patterns)))
(setq vectors
         (mapcar
          #'(lambda (x)
              (subtract-two-lists
               x (first pattern)))
          (rest pattern)))
(setq vector (first vectors))
(setq result
      (assoc vector growing-list :test #'equalp))

(setq patterns (rest patterns))

(setq growing-list
      (append
          growing-list
          (list
           (cons
            vector
            (maximal-translatable-pattern
             vector dataset)))))
(setq vectors (rest vectors))






