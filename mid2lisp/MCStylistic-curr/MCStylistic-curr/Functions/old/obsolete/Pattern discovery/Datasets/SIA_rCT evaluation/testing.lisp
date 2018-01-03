

(defun difference-list-sorted-asc (pattern)
  (if (<= (length pattern) 1) ()
    (merge
     'list
     (mapcar
          #'(lambda (x)
              (subtract-two-lists
               x (first pattern)))
          (rest pattern))
     (difference-list-sorted-asc (rest pattern))
     #'vector<vector-t-or-nil)))

(setq
 union-of-patterns
 (unions-multidimensional-sorted-asc
  (list
   A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 C1 C2 C3 E1 E2 F1 F2
   F3 F4 G1 G2)))
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets"
  "/D-250-test.csv"))

(setq fname "D-250-test")
(setq
 path-origin
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets/"))
(setq
 path-destination
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Write to files/"))
(setq compactness-threshold 9/10)
(setq cardinality-threshold 6)
(setq region-type "convex hull")
(setq r-superdiagonals 1)
(setq
 benchmark-labels
 '("A" "B" "C" "E" "F" "G" "H" "I" "J" "K"))
(progn
  (setq
   benchmark-probes
   (list A1 B1 C1 E1 F1 G1 H1 I1 J1 K1))
  "Yes!")

(evaluate-SIACT-SIA_rCT-on-dataset
 fname path-origin path-destination
 compactness-threshold cardinality-threshold
 region-type r-superdiagonals benchmark-labels
 benchmark-probes)


(setq
 union-of-patterns
 (unions-multidimensional-sorted-asc
  (list
   A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 C1 C2 C3 E1 E2 F1 F2
   F3 F4 G1 G2 H1 H2 H3)))
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets"
  "/D-A2H.csv"))

(setq fname "D-A2H")
(setq
 path-origin
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets/"))
(setq
 path-destination
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Write to files/"))
(setq compactness-threshold 9/10)
(setq cardinality-threshold 6)
(setq region-type "convex hull")
(setq r-superdiagonals 1)
(setq benchmark-labels '("A" "B" "C" "E" "F" "G" "H"))
(progn
  (setq benchmark-probes (list A1 B1 C1 E1 F1 G1 H1))
  "Yes!")

(evaluate-SIACT-SIA_rCT-on-dataset
 fname path-origin path-destination
 compactness-threshold cardinality-threshold
 region-type r-superdiagonals benchmark-labels
 benchmark-probes)

; Why has the recall dropped?
(progn
  (setq dataset
        (csv2dataset
         (concatenate
          'string path-origin fname ".csv")))
  "Yes!")
; This is copied from the file D-A2H-SIA_r.txt.
(setq
 pattern
 '((22 61) (23 59) (24 59) (24 60) (25 58) (25 61)
   (25 63) (26 57) (26 62) (27 53) (27 55) (27 58)
   (27 61) (27 63) (27 65) (27 67) (27 68) (28 58)
   (28 59) (29 60) (29 62) (30 61) (31 60) (31 62)))
(compact-subpatterns
 pattern dataset 9/10 6 "convex hull")

(setq
 pattern2
 '((22 61) (23 59) (24 59) (24 60) (25 58) (25 61)
   (25 63) (26 57) (26 62) (27 53) (27 55) (27 58)
   (27 61) (27 63) (27 65) (27 67) (27 68) (28 58)
   (28 59) (29 60) (29 62) (30 61) (30 87) (31 60)
   (31 62)))
(compact-subpatterns
 pattern2 dataset 1 6 "convex hull")

(setq
 pattern
 '((1 3) (1 7) (10 15) (13 15) (15 14) (16 35) (16 39)
   (18 18) (20 88) (21 18) (22 89) (23 17) (23 59)
   (23 89) (24 59) (24 60) (24 87) (24 88) (24 90)
   (24 92) (25 61) (25 63) (26 62) (26 88) (27 61)
   (27 63) (27 88) (28 86) (28 87) (28 89) (28 91)
   (30 87) (31 87) (34 4) (34 8) (54 71) (54 96)
   (70 33) (71 33) (71 34) (72 35) (72 37) (73 36)
   (74 35) (74 37) (81 63) (84 63) (86 62)))
(compact-subpatterns
 pattern dataset 9/10 6 "convex hull")


(setq
 union-of-patterns
 (unions-multidimensional-sorted-asc
  (list
   A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 C1 C2 C3 E1 E2 F1 F2
   F3 F4 G1 G2 H1 H2 H3 I1 I2)))
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets"
  "/D-A2I.csv"))

(setq fname "D-A2I")
(setq
 path-origin
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets/"))
(setq
 path-destination
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Write to files/"))
(setq compactness-threshold 9/10)
(setq cardinality-threshold 6)
(setq region-type "convex hull")
(setq r-superdiagonals 1)
(setq
 benchmark-labels '("A" "B" "C" "E" "F" "G" "H" "I"))
(progn
  (setq
   benchmark-probes (list A1 B1 C1 E1 F1 G1 H1 I1))
  "Yes!")

(evaluate-SIACT-SIA_rCT-on-dataset
 fname path-origin path-destination
 compactness-threshold cardinality-threshold
 region-type r-superdiagonals benchmark-labels
 benchmark-probes)


(setq
 union-of-patterns
 (unions-multidimensional-sorted-asc
  (list
   A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 C1 C2 C3 E1 E2 F1 F2
   F3 F4 G1 G2 H1 H2 H3 I1 I2 J1 J2)))
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets"
  "/D-A2J.csv"))

(setq fname "D-A2J")
(setq
 path-origin
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets/"))
(setq
 path-destination
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Write to files/"))
(setq compactness-threshold 9/10)
(setq cardinality-threshold 6)
(setq region-type "convex hull")
(setq r-superdiagonals 1)
(setq
 benchmark-labels
 '("A" "B" "C" "E" "F" "G" "H" "I" "J"))
(progn
  (setq
   benchmark-probes (list A1 B1 C1 E1 F1 G1 H1 I1 J1))
  "Yes!")

(evaluate-SIACT-SIA_rCT-on-dataset
 fname path-origin path-destination
 compactness-threshold cardinality-threshold
 region-type r-superdiagonals benchmark-labels
 benchmark-probes)


(setq
 union-of-patterns
 (unions-multidimensional-sorted-asc
  (list
   A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 C1 C2 C3 E1 E2 F1 F2
   F3 F4 G1 G2 H1 H2 H3 I1 I2 J1 J2 K1 K2)))
(dataset2csv
 union-of-patterns
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets"
  "/D-A2K.csv"))

(setq fname "D-A2K")
(setq
 path-origin
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Test datasets/"))
(setq
 path-destination
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/SIA_rCT evaluation/Write to files/"))
(setq compactness-threshold 9/10)
(setq cardinality-threshold 6)
(setq region-type "convex hull")
(setq r-superdiagonals 1)
(setq
 benchmark-labels
 '("A" "B" "C" "E" "F" "G" "H" "I" "J" "K"))
(progn
  (setq
   benchmark-probes
   (list A1 B1 C1 E1 F1 G1 H1 I1 J1 K1))
  "Yes!")

(evaluate-SIACT-SIA_rCT-on-dataset
 fname path-origin path-destination
 compactness-threshold cardinality-threshold
 region-type r-superdiagonals benchmark-labels
 benchmark-probes)




(progn
  (setq dataset
        (csv2dataset
         (concatenate
          'string path-origin fname ".csv")))
  "Yes!")
(setq time-SIA
         (abs
          (- (get-internal-real-time)
             (progn
               (SIA-reflected-merge-sort
                dataset
                (concatenate
                 'string
                 path-destination fname "-SIA"))
               (get-internal-real-time)))))
(progn
  (setq output-SIA
        (read-from-file
         (concatenate
          'string
          path-destination fname "-SIA.txt")))
  "Yes!")
(setq true-pos-SIA
         (benchmark-labels-discovered-rassoc
          benchmark-labels benchmark-probes
          output-SIA))
(setq recall-SIA
         (/
          (length true-pos-SIA)
          (length benchmark-labels)))
(setq precision-SIA
         (/
          (length true-pos-SIA)
          (length output-SIA)))
(setq time-CT1
         (abs
          (- (get-internal-real-time)
             (progn
               (compactness-trawler
                output-SIA dataset
                (concatenate
                 'string
                 path-destination fname "-SIACT.txt")
                compactness-threshold
                cardinality-threshold region-type)
               (get-internal-real-time)))))
(progn
  (setq output-SIACT
        (read-from-file
         (concatenate
          'string
          path-destination fname "-SIACT.txt")))
  "Yes!")
(setq true-pos-SIACT
         (benchmark-labels-discovered-assoc
          benchmark-labels benchmark-probes
          output-SIACT))
(setq recall-SIACT
         (/
          (length true-pos-SIACT)
          (length benchmark-labels)))
(setq precision-SIACT
         (/
          (length true-pos-SIACT)
          (length output-SIACT)))
(setq time-SIA_r
         (abs
          (- (get-internal-real-time)
             (progn
               (structural-induction-algorithm-r
                dataset r-superdiagonals
                (concatenate
                 'string
                 path-destination fname "-SIA_r.txt"))
               (get-internal-real-time)))))
(progn
  (setq output-SIA_r
        (read-from-file
         (concatenate
          'string
          path-destination fname "-SIA_r.txt")))
  "Yes!")
(setq time-CT2
         (abs
          (- (get-internal-real-time)
             (progn
               (compactness-trawler
                output-SIA_r dataset
                (concatenate
                 'string
                 path-destination fname
                 "-SIA_rCT.txt")
                compactness-threshold
                cardinality-threshold region-type)
               (get-internal-real-time)))))
(progn
  (setq output-SIA_rCT
        (read-from-file
         (concatenate
          'string
          path-destination fname "-SIA_rCT.txt")))
  "Yes!")
(setq true-pos-SIA_rCT
         (benchmark-labels-discovered-assoc
          benchmark-labels benchmark-probes
          output-SIA_rCT))
(setq recall-SIA_rCT
         (/
          (length true-pos-SIA_rCT)
          (length benchmark-labels)))
(setq precision-SIA_rCT
         (/
          (length true-pos-SIA_rCT)
          (length output-SIA_rCT)))




