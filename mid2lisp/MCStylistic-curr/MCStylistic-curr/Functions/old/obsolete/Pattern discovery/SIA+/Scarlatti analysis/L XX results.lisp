#| Tom Collins
   Friday 12 February 2010
   Complete Friday 12 February 2010 |#

#| The purpose is to apply the pattern discovery
algorithm to ?. |#

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
  "/Scarlatti sonatas/L XX.lisp"))
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
; size of full dataset is ?.

#| Step 2 - Run COSIATEC on projection (1 1 0 1 0). |#
(time
 (COSIATEC
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 1 0 1 0)")))
; ? seconds.

#| Step 3 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L XX analysis.lisp"))
(progn
  (setq
   alist-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 1 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-1-0 alist-1-1-0-1-0)
; TP = ?.
(length alist-1-1-0-1-0)
; TP + FP = ?.
(length targets-1-1-0-1-0)
; TP + TN = ?.

#| Comments - ?. |#

#| Step 4 - Run COSIATEC on projection (1 0 1 1 0). |#
(time
 (COSIATEC
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 0 1 1 0)")))
; ? seconds.

#| Step 5 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   alist-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 0 1 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-1-0 alist-1-0-1-1-0)
; TP = ?.
(length alist-1-0-1-1-0)
; TP + FP = ?.
(length targets-1-0-1-1-0)
; TP + TN = ?.

#| Comments - ?. |#

#| Step 6 - Run COSIATEC on projection (1 1 0 0 0). |#
(time
 (COSIATEC
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 1 0 0 0)")))
; ? seconds.

#| Step 7 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   alist-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 1 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-1-0-0-0 alist-1-1-0-0-0)
; TP = ?.
(length alist-1-1-0-0-0)
; TP + FP = ?.
(length targets-1-1-0-0-0)
; TP + TN = ?.

#| Comments - ?. |#

#| Step 8 - Run COSIATEC on projection (1 0 1 0 0). |#
(time
 (COSIATEC
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 0 1 0 0)")))
; ? seconds.

#| Step 9 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   alist-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 0 1 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-1-0-0 alist-1-0-1-0-0)
; TP = ?.
(length alist-1-0-1-0-0)
; TP + FP = ?.
(length targets-1-0-1-0-0)
; TP + TN = ?.

#| Comments - ?. |#

#| Step 10 - Run COSIATEC on projection
(1 0 0 1 0). |#
(time
 (COSIATEC
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 0 0 1 0)")))
; ? seconds.

#| Step 11 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   alist-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 0 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-assoc
 targets-1-0-0-1-0 alist-1-0-0-1-0)
; TP = ?.
(length alist-1-0-0-1-0)
; TP + FP = ?.
(length targets-1-0-0-1-0)
; TP + TN = ?.

#| Comments - ?. |#

#| Step 12 - Run COSIATEC on projection
(1 1* 0 1 0). |#
(time
 (COSIATEC-mod-2nd-n
  dataset-1-1*-0-1-0 *pitch-mod*
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 1@ 0 1 0)")))
; ? seconds.

#| Step 13 - Results for projection (1 1@ 0 1 0). |#
(progn
  (setq
   alist-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 1@ 0 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-1-0 alist-1-1*-0-1-0 *pitch-mod*)
; TP = ?.
(length alist-1-1*-0-1-0)
; TP + FP = ?.
(length targets-1-1*-0-1-0)
; TP + TN = ?.

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
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 0 1@ 1 0)")))
; ? seconds.

#| Step 15 - Results for projection (1 0 1@ 1 0). |#
(progn
  (setq
   alist-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 0 1@ 1 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-1-0 alist-1-0-1*-1-0 *pitch-mod*)
; TP = ?.
(length alist-1-0-1*-1-0)
; TP + FP = ?.
(length targets-1-0-1*-1-0)
; TP + TN = ?.

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
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 1@ 0 0 0)")))
; ? seconds.

#| Step 17 - Results for projection (1 1@ 0 0 0). |#
(progn
  (setq
   alist-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 1@ 0 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-1*-0-0-0 alist-1-1*-0-0-0 *pitch-mod*)
; TP = ?.
(length alist-1-1*-0-0-0)
; TP + FP = ?.
(length targets-1-1*-0-0-0)
; TP + TN = ?.

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
   "/Pattern discovery/SIA+/Write to files/L XX"
   "/L XX (1 0 1@ 0 0)")))
; ? seconds.

#| Step 19 - Results for projection (1 0 1@ 0 0). |#
(progn
  (setq
   alist-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIA+/Write to files/L XX"
     "/L XX (1 0 1@ 0 0) COSIATEC.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-assoc
 targets-1-0-1*-0-0 alist-1-0-1*-0-0 *pitch-mod*)
; TP = ?.
(length alist-1-0-1*-0-0)
; TP + FP = ?.
(length targets-1-0-1*-0-0)
; TP + TN = ?.

#| Comments - ?. |#
