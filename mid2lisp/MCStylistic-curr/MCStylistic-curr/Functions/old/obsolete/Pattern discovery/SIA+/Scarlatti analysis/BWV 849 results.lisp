#| Tom Collins
   Friday 12 February 2010
   Complete Friday 12 February 2010 |#

#| The purpose is to apply the pattern discovery
algorithm to Bach's Prelude No. 4 in C# Minor,
BWV 849. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIA+"
  "/evaluation-for-SIA+.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIA+"
  "/further-structural-inference-algorithms.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/structural-inference-algorithm.lisp"))


#| Step 1 - Create datasets. |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Bach preludes/BWV 849.lisp"))
(progn
  (setq
   dataset-1-1-0-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 1 0)))
  (setq
   dataset-1-0-1-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 0 1 1 0)))
  (setq
   dataset-1-1-0-0-0
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 0 0)))
  (setq
   dataset-1-0-1-0-0
   (orthogonal-projection-unique-equalp
    dataset '(1 0 1 0 0)))
  (setq
   dataset-1-0-0-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 0 0 1 0)))
  (identity "Yes!"))
(progn
  (setq
   dataset-1-1*-0-1-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-1-0 12 1)))
  (setq
   dataset-1-0-1*-1-0
   (sort-dataset-asc
    (mod-column
     dataset-1-0-1-1-0 7 1)))
  (setq
   dataset-1-1*-0-0-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-0-0 12 1)))
  (setq
   dataset-1-0-1*-0-0
   (sort-dataset-asc
    (mod-column
     dataset-1-0-1-0-0 7 1)))
  (identity "Yes!"))
; size of full dataset is 666.

#| Step 2 - Run COSIATEC on projection (1 1 0 1 0). |#
(time
 (COSIATEC
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 1 0 1 0)")))
; 46316.300000 seconds.

#| Step 3 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/BWV 849 analysis.lisp"))
(progn
  (setq
   alist-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 1 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-1-0 alist-1-1-0-1-0)
; TP = 0.
(length alist-1-1-0-1-0)
; TP + FP = 51.
(length targets-1-1-0-1-0)
; TP + TN = 2.

#| Comments - ?. |#

#| Step 4 - Run COSIATEC on projection (1 0 1 1 0). |#
(time
 (COSIATEC
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 0 1 1 0)")))
; 43568.130000 seconds.

#| Step 5 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   alist-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 0 1 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-1-0 alist-1-0-1-1-0)
; TP = 0.
(length alist-1-0-1-1-0)
; TP + FP = 38.
(length targets-1-0-1-1-0)
; TP + TN = 8.

#| Comments - ?. |#

#| Step 6 - Run COSIATEC on projection (1 1 0 0 0). |#
(time
 (COSIATEC
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 1 0 0 0)")))
; 41490.492000 seconds.

#| Step 7 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   alist-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 1 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-0-0 alist-1-1-0-0-0)
; TP = 0.
(length alist-1-1-0-0-0)
; TP + FP = 33.
(length targets-1-1-0-0-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 8 - Run COSIATEC on projection (1 0 1 0 0). |#
(time
 (COSIATEC
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 0 1 0 0)")))
; 18708.854000 seconds.

#| Step 9 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   alist-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 0 1 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-0-0 alist-1-0-1-0-0)
; TP = 0.
(length alist-1-0-1-0-0)
; TP + FP = 27.
(length targets-1-0-1-0-0)
; TP + TN = 8.

#| Comments - ?. |#

#| Step 10 - Run COSIATEC on projection
(1 0 0 1 0). |#
(time
 (COSIATEC
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 0 0 1 0)")))
; 8166.770000 seconds.

#| Step 11 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   alist-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 0 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-0-1-0 alist-1-0-0-1-0)
; TP = 0.
(length alist-1-0-0-1-0)
; TP + FP = 17.
(length targets-1-0-0-1-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 12 - Run COSIATEC on projection
(1 1* 0 1 0). |#
(time
 (COSIATEC-mod-2nd-n
  dataset-1-1*-0-1-0 *pitch-mod*
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 1@ 0 1 0)")))
; 44211.785000 seconds.

#| Step 13 - Results for projection (1 1@ 0 1 0). |#
(progn
  (setq
   alist-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 1@ 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-1-0 alist-1-1*-0-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-1-0)
; TP + FP = 4.
(length targets-1-1*-0-1-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 14 - Run COSIATEC on projection
(1 0 1* 1 0). |#
(setq *pitch-mod* 7)

(time
 (COSIATEC-mod-2nd-n
  dataset-1-0-1*-1-0 *pitch-mod*
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 0 1@ 1 0)")))
; 43093.270000 seconds.

#| Step 15 - Results for projection (1 0 1@ 1 0). |#
(progn
  (setq
   alist-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 0 1@ 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-1-0 alist-1-0-1*-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-1-0)
; TP + FP = 26.
(length targets-1-0-1*-1-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 16 - Run COSIATEC on projection
(1 1* 0 0 0). |#
(setq *pitch-mod* 12)

(time
 (COSIATEC-mod-2nd-n
  dataset-1-1*-0-0-0 *pitch-mod*
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 1@ 0 0 0)")))
; 23181.367000 seconds.

#| Step 17 - Results for projection (1 1@ 0 0 0). |#
(progn
  (setq
   alist-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 1@ 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-0-0 alist-1-1*-0-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-0-0)
; TP + FP = 23.
(length targets-1-1*-0-0-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 18 - Run COSIATEC on projection
(1 0 1* 0 0). |#
(setq *pitch-mod* 7)

(time
 (COSIATEC-mod-2nd-n
  dataset-1-0-1*-0-0 *pitch-mod*
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/BWV 849"
   "/BWV 849 (1 0 1@ 0 0)")))
; 29551.621000 seconds.

#| Step 19 - Results for projection (1 0 1@ 0 0). |#
(progn
  (setq
   alist-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/BWV 849"
     "/BWV 849 (1 0 1@ 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-0-0 alist-1-0-1*-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-0-0)
; TP + FP = 19.
(length targets-1-0-1*-0-0)
; TP + TN = 0.

#| Comments - ?. |#
