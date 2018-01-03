#| Tom Collins
   Friday February 12 2010
   Complete Friday February 12 2010 |#

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
#|
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIA+"
  "/further-structural-inference-algorithms.lisp"))
|#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/structural-inference-algorithm.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))

#| Step 1 - Results for projection (1 1 0 1 0). |#
; SIA took 911.179800 seconds.
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
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-1-0-1-0 alist-1-1-0-1-0)
; TP = 0.
(length alist-1-1-0-1-0)
; TP + FP = 112328.
(length targets-1-1-0-1-0)
; TP + TN = 3.

#| Comments - ?. |#

#| Step 2 - Results for projection (1 0 1 1 0). |#
; SIA took 817.850300 seconds.
(progn
  (setq
   alist-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-0-1-1-0 alist-1-0-1-1-0)
; TP = 0.
(length alist-1-0-1-1-0)
; TP + FP = 102544.
(length targets-1-0-1-1-0)
; TP + TN = 4.

#| Comments - ?. |#

#| Step 3 - Results for projection (1 1 0 0 0). |#
; SIA took 581.804000 seconds.
(progn
  (setq
   alist-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-1-0-0-0 alist-1-1-0-0-0)
; TP = 0.
(length alist-1-1-0-0-0)
; TP + FP = 60670.
(length targets-1-1-0-0-0)
; TP + TN = 5.

#| Step 4 - Results for projection (1 0 1 0 0). |#
; SIA took 518.878050 seconds.
(progn
  (setq
   alist-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-0-1-0-0 alist-1-0-1-0-0)
; TP = 0.
(length alist-1-0-1-0-0)
; TP + FP = 49662.
(length targets-1-0-1-0-0)
; TP + TN = 2.

#| Comments - ?. |#

#| Step 5 - Results for projection (1 0 0 1 0). |#
; SIA took 93.089035 seconds.
(progn
  (setq
   alist-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 0 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-0-0-1-0 alist-1-0-0-1-0)
; TP = 0.
(length alist-1-0-0-1-0)
; TP + FP = 16871.
(length targets-1-0-0-1-0)
; TP + TN = 3.

#| Comments - ?. |#

#| Step 6 - Results for projection (1 1@ 0 1 0). |#
; SIA took 538.460750 seconds.
(progn
  (setq
   alist-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-rassoc
 targets-1-1*-0-1-0 alist-1-1*-0-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-1-0)
; TP + FP = 58834.
(length targets-1-1*-0-1-0)
; TP + TN = ?.

#| Comments - ?. |#

#| Step 7 - Results for projection (1 0 1@ 1 0). |#
; SIA took ? seconds.
(setq *pitch-mod* 7)
(progn
  (setq
   alist-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1@ 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-rassoc
 targets-1-0-1*-1-0 alist-1-0-1*-1-0 *pitch-mod*)
; TP = ?.
(length alist-1-0-1*-1-0)
; TP + FP = ?.
(length targets-1-0-1*-1-0)
; TP + TN = ?.

#| Comments - ?. |#

#| Step 8 - Results for projection (1 1@ 0 0 0). |#
; SIA took 171.373400 seconds.
(setq *pitch-mod* 12)
(progn
  (setq
   alist-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-rassoc
 targets-1-1*-0-0-0 alist-1-1*-0-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-0-0)
; TP + FP = 18295.
(length targets-1-1*-0-0-0)
; TP + TN = 5.

#| Comments - ?. |#

#| Step 9 - Results for projection (1 0 1@ 0 0). |#
; SIA took ? seconds.
(setq *pitch-mod* 7)
(progn
  (setq
   alist-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1@ 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-rassoc
 targets-1-0-1*-0-0 alist-1-0-1*-0-0 *pitch-mod*)
; TP = ?.
(length alist-1-0-1*-0-0)
; TP + FP = ?.
(length targets-1-0-1*-0-0)
; TP + TN = ?.

#| Comments - ?. |#
