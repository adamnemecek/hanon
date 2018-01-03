#| Tom Collins
   Friday 12 February 2010
   Complete Friday 12 February 2010 |#

#| The purpose is to apply the pattern discovery
algorithm to Scarlatti's Sonata in C Minor, L. 10
(K. 84). |#

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
  "/Scarlatti sonatas/L 10.lisp"))
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
; size of full dataset is 872.

#| Step 2 - Run COSIATEC on projection (1 1 0 1 0). |#
(time
 (COSIATEC
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 1 0 1 0)")))
; ? seconds. We are not sure---encountered stack
; overflow. 106069.016000 seconds at least.

#| Step 3 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L 10 analysis.lisp"))
(progn
  (setq
   alist-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 1 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-1-0 alist-1-1-0-1-0)
; TP = 2.
(length alist-1-1-0-1-0)
; TP + FP = 34.
(length targets-1-1-0-1-0)
; TP + TN = 4.

#| Comments - ?. |#

#| Step 4 - Run COSIATEC on projection (1 0 1 1 0). |#
(time
 (COSIATEC
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 0 1 1 0)")))
; 176178.800000 seconds.

#| Step 5 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   alist-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 0 1 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-1-0 alist-1-0-1-1-0)
; TP = 1.
(length alist-1-0-1-1-0)
; TP + FP = 25.
(length targets-1-0-1-1-0)
; TP + TN = 7.

#| Comments - ?. |#

#| Step 6 - Run COSIATEC on projection (1 1 0 0 0). |#
(time
 (COSIATEC
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 1 0 0 0)")))
; 150949.300000 seconds.

#| Step 7 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   alist-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 1 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-0-0 alist-1-1-0-0-0)
; TP = 1.
(length alist-1-1-0-0-0)
; TP + FP = 30.
(length targets-1-1-0-0-0)
; TP + TN = 3.

#| Comments - ?. |#

#| Step 8 - Run COSIATEC on projection (1 0 1 0 0). |#
(time
 (COSIATEC
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 0 1 0 0)")))
; 101444.830000 seconds.

#| Step 9 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   alist-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 0 1 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-0-0 alist-1-0-1-0-0)
; TP = 0.
(length alist-1-0-1-0-0)
; TP + FP = 19.
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
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 0 0 1 0)")))
; 15983.387000 seconds.

#| Step 11 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   alist-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 0 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-0-1-0 alist-1-0-0-1-0)
; TP = 0.
(length alist-1-0-0-1-0)
; TP + FP = 9.
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
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 1@ 0 1 0)")))
; 86403.640000 seconds.

#| Step 13 - Results for projection (1 1@ 0 1 0). |#
(progn
  (setq
   alist-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 1@ 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-1-0 alist-1-1*-0-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-1-0)
; TP + FP = 25.
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
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 0 1@ 1 0)")))
; 65106.070000 seconds.

#| Step 15 - Results for projection (1 0 1@ 1 0). |#
(progn
  (setq
   alist-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 0 1@ 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-1-0 alist-1-0-1*-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-1-0)
; TP + FP = 19.
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
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 1@ 0 0 0)")))
; 51835.440000 seconds.

#| Step 17 - Results for projection (1 1@ 0 0 0). |#
(progn
  (setq
   alist-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 1@ 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-0-0 alist-1-1*-0-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-0-0)
; TP + FP = 21.
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
   "/Pattern discovery/SIA+/Write to files/L 10"
   "/L 10 (1 0 1@ 0 0)")))
; 61426.420000 seconds.

#| Step 19 - Results for projection (1 0 1@ 0 0). |#
(progn
  (setq
   alist-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 10"
     "/L 10 (1 0 1@ 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-0-0 alist-1-0-1*-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-0-0)
; TP + FP = 17.
(length targets-1-0-1*-0-0)
; TP + TN = 1.

#| Comments - ?. |#
