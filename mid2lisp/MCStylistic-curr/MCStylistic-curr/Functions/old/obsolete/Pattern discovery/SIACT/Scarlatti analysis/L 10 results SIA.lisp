#| Tom Collins
   Friday February 12 2010
   Complete Friday February 12 2010 |#

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
; SIA took 2993.744000 seconds.
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
     "/SIACT/Write to files"
     "/L 10 (1 1 0 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-1-0-1-0 alist-1-1-0-1-0)
; TP = 2.
(length alist-1-1-0-1-0)
; TP + FP = 133897.
(length targets-1-1-0-1-0)
; TP + TN = 4.

#| Comments - ?. |#

#| Step 2 - Results for projection (1 0 1 1 0). |#
; SIA took 2543.516400 seconds.
(progn
  (setq
   alist-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-0-1-1-0 alist-1-0-1-1-0)
; TP = 0.
(length alist-1-0-1-1-0)
; TP + FP = 102316.
(length targets-1-0-1-1-0)
; TP + TN = 7.

#| Comments - ?. |#

#| Step 3 - Results for projection (1 1 0 0 0). |#
; SIA took 1384.710900 seconds.
(progn
  (setq
   alist-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1 0 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-1-0-0-0 alist-1-1-0-0-0)
; TP = 1.
(length alist-1-1-0-0-0)
; TP + FP = 51510.
(length targets-1-1-0-0-0)
; TP + TN = 3.

#| Step 4 - Results for projection (1 0 1 0 0). |#
; SIA took 909.317000 seconds.
(progn
  (setq
   alist-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-0-1-0-0 alist-1-0-1-0-0)
; TP = 2.
(length alist-1-0-1-0-0)
; TP + FP = 34398.
(length targets-1-0-1-0-0)
; TP + TN = 8.

#| Comments - ?. |#

#| Step 5 - Results for projection (1 0 0 1 0). |#
; SIA took 90.626640 seconds.
(progn
  (setq
   alist-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 0 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-translation-in-list-rassoc
 targets-1-0-0-1-0 alist-1-0-0-1-0)
; TP = 0.
(length alist-1-0-0-1-0)
; TP + FP = 6639.
(length targets-1-0-0-1-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 6 - Results for projection (1 1@ 0 1 0). |#
; SIA took 1373.461400 seconds.
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
; TP + TN = 0.

#| Comments - ?. |#

#| Step 7 - Results for projection (1 0 1@ 1 0). |#
; SIA took 896.441900 seconds.
(setq *pitch-mod* 7)
(progn
  (setq
   alist-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 1 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-rassoc
 targets-1-0-1*-1-0 alist-1-0-1*-1-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-1-0)
; TP + FP = 33746.
(length targets-1-0-1*-1-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 8 - Results for projection (1 1@ 0 0 0). |#
; SIA took 271.903140 seconds.
(setq *pitch-mod* 12)
(progn
  (setq
   alist-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1@ 0 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-rassoc
 targets-1-1*-0-0-0 alist-1-1*-0-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-1*-0-0-0)
; TP + FP = 11858.
(length targets-1-1*-0-0-0)
; TP + TN = 0.

#| Comments - ?. |#

#| Step 9 - Results for projection (1 0 1@ 0 0). |#
; SIA took 177.554280 seconds.
(setq *pitch-mod* 7)
(progn
  (setq
   alist-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 0 0) SIA 1.txt")))
  (identity "Yes!"))

(number-of-targets-trans-mod-in-list-rassoc
 targets-1-0-1*-0-0 alist-1-0-1*-0-0 *pitch-mod*)
; TP = 0.
(length alist-1-0-1*-0-0)
; TP + FP = 7818.
(length targets-1-0-1*-0-0)
; TP + TN = 1.

#| Comments - ?. |#
