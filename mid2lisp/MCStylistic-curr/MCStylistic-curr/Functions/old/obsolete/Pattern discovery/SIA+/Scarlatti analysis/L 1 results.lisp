#| Tom Collins
   Monday 18 January 2010
   Complete Tuesday 26 January 2010 |#

#| The purpose is to apply the pattern discovery
algorithm to Scarlatti's Sonata in C Major, L. 1
(K. 514). |#

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
  "/Scarlatti sonatas/L 1.lisp"))
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
; size of full dataset is 628.

#| Step 2 - Run COSIATEC on projection (1 1 0 1 0). |#
(time
 (COSIATEC
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 1 0 1 0)")))
; 24231.309000 seconds.

#| Step 3 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L 1 analysis.lisp"))
(progn
  (setq 
   alist-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 1 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-1-0 alist-1-1-0-1-0)
; TP = 0.
(length alist-1-1-0-1-0)
; TP + FP = 18.
(length targets-1-1-0-1-0)
; TP + TN = 8.

#| Comments - ?. |#

#| Step 4 - Run COSIATEC on projection (1 0 1 1 0). |#
(time
 (COSIATEC
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 0 1 1 0)")))
; 21821.578000 seconds.

#| Step 5 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   alist-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 0 1 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-1-0 alist-1-0-1-1-0)
; TP = 0.
(length alist-1-0-1-1-0)
; TP + FP = 18.
(length targets-1-0-1-1-0)
; TP + TN = 4.

#| Comments - ?. |#

#| Step 6 - Run COSIATEC on projection (1 1 0 0 0). |#
(time
 (COSIATEC
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 1 0 0 0)")))
; 30854.072000 seconds.

#| Step 7 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   alist-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 1 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-0-0 alist-1-1-0-0-0)
; TP = 0.
(length alist-1-1-0-0-0)
; TP + FP = 16.
(length targets-1-1-0-0-0)
; TP + TN = 5.

#| Comments - ?. |#

#| Step 8 - Run COSIATEC on projection (1 0 1 0 0). |#
(time
 (COSIATEC
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 0 1 0 0)")))
; 26969.584000 seconds.

#| Step 9 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   alist-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 0 1 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-0-0 alist-1-0-1-0-0)
; TP = 0.
(length alist-1-0-1-0-0)
; TP + FP = 17.
(length targets-1-0-1-0-0)
; TP + TN = 2.

#| Comments - ?. |#

#| Step 10 - Run COSIATEC on projection
(1 0 0 1 0). |#
(time
 (COSIATEC
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 0 0 1 0)")))
; 2056.012700 seconds.

#| Step 11 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   alist-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 0 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-0-1-0 alist-1-0-0-1-0)
; TP = 0.
(length alist-1-0-0-1-0)
; TP + FP = 8.
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
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 1@ 0 1 0)")))
; 13560.706000 seconds.

#| Step 13 - Results for projection (1 1@ 0 1 0). |#
(progn
  (setq
   alist-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 1@ 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-1-0 alist-1-1*-0-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-1-0)
; TP + FP = 6.
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
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 0 1@ 1 0)")))
; 15834.314000 seconds.

#| Step 15 - Results for projection (1 0 1@ 1 0). |#
(progn
  (setq
   alist-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 0 1@ 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-1-0 alist-1-0-1*-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-1-0)
; TP + FP = 11.
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
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 1@ 0 0 0)")))
; 9875.373000 seconds.

#| Step 17 - Results for projection (1 1@ 0 0 0). |#
(progn
  (setq
   alist-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 1@ 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-0-0 alist-1-1*-0-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-0-0)
; TP + FP = 9.
(length targets-1-1*-0-0-0)
; TP + TN = 2.

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
   "/Pattern discovery/SIA+/Write to files/L 1"
   "/L 1 (1 0 1@ 0 0)")))
; 9474.234000 seconds.

#| Step 19 - Results for projection (1 0 1@ 0 0). |#
(progn
  (setq
   alist-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L 1"
     "/L 1 (1 0 1@ 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-0-0 alist-1-0-1*-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-0-0)
; TP + FP = 8.
(length targets-1-0-1*-0-0)
; TP + TN = 0.

#| Comments - ?. |#
