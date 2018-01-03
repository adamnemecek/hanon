#| Tom Collins
   Tuesday 3 February January 2010
   Incomplete |#

#| The purpose is to apply the pattern discovery
algorithm to Scarlatti's Sonata in C Major, L. 2
(K. 384). |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/compactness-trawl.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/evaluation-for-SIACT.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/hash-tables.lisp"))
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

#| Step 1 - Set parameters. |#
(setq *compact-thresh* 2/3)
(setq *cardina-thresh* 5)

#| Step 2 - Create datasets. |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Scarlatti sonatas/L 2.lisp"))
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
; size of full dataset is 627.

#| Step 3 - Run SIA on projection (1 1 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 1 0 1 0) SIA")
  196251))
; 951.814760 seconds.

#| Step 4 - Run SIACT on projection (1 1 0 1 0). |#
(progn
  (setq
   SIA-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-1-0 dataset-1-1-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 8.417836 seconds.
(length SIA-1-1-0-1-0)
; size of SIA-output is 104015.

#| Step 5 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L 2 analysis.lisp"))
(progn
  (setq
   SIACT-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-1-0 dataset-1-1-0-1-0))))
; 77.629190 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-1-0 hash-1-1-0-1-0 "pattern")
; TP = ?.
(length hash-1-1-0-1-0)
; TP + FP = 122.
(length targets-1-1-0-1-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-1-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 1 0 1 0) hash.txt"))
#| Comments - ?. |#

#| Step 6 - Run SIA on projection (1 0 1 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 0 1 1 0) SIA")
  196878))
; ? seconds.

#| Step 7 - Run SIACT on projection (1 0 1 1 0). |#
(progn
  (setq
   SIA-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-1-0 dataset-1-0-1-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; ? seconds.
(length SIA-1-0-1-1-0)
; size of SIA-output is ?.

#| Step 8 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   SIACT-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-1-0 dataset-1-0-1-1-0))))
; ? seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-1-0 hash-1-0-1-1-0 "pattern")
; TP = ?.
(length hash-1-0-1-1-0)
; TP + FP = ?.
(length targets-1-0-1-1-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-0-1-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 0 1 1 0) hash.txt"))
#| Comments - ?. |#

#| Step 9 - Run SIA on projection (1 1 0 0 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 1 0 0 0) SIA")
  196878))
; ? seconds.

#| Step 10 - Run SIACT on projection (1 1 0 0 0). |#
(progn
  (setq
   SIA-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-0-0 dataset-1-1-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 9.025578 seconds.
(length SIA-1-1-0-0-0)
; size of SIA-output is ?.

#| Step 11 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   SIACT-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1 0 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-0-0 dataset-1-1-0-0-0))))
; ? seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-0-0 hash-1-1-0-0-0 "pattern")
; TP = ?.
(length hash-1-1-0-0-0)
; TP + FP = ?.
(length targets-1-1-0-0-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-1-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 1 0 0 0) hash.txt"))
#| Comments - Pattern O is missing, as expected. |#

#| Step 12 - Run SIA on projection (1 0 1 0 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 0 1 0 0) SIA")
  196878))
; ? seconds.

#| Step 13 - Run SIACT on projection (1 0 1 0 0). |#
(progn
  (setq
   SIA-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-0-0 dataset-1-0-1-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 9.407164 seconds.
(length SIA-1-0-1-0-0)
; size of SIA-output is ?.

#| Step 14 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   SIACT-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-0-0 dataset-1-0-1-0-0))))
; ? seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-0-0 hash-1-0-1-0-0 "pattern")
; TP = ?.
(length hash-1-0-1-0-0)
; TP + FP = ?.
(length targets-1-0-1-0-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-0-1-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 0 1 0 0) hash.txt"))
#| Comments - ?. |#

#| Step 15 - Run SIA on projection (1 0 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 0 0 1 0) SIA")
  196878))
; ? seconds.

#| Step 16 - Run SIACT on projection (1 0 0 1 0). |#
(progn
  (setq
   SIA-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-0-1-0 dataset-1-0-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; ? seconds.
(length SIA-1-0-0-1-0)
; size of SIA-output is ?.

#| Step 17 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   SIACT-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-0-1-0 dataset-1-0-0-1-0))))
; ? seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-0-1-0 hash-1-0-0-1-0 "pattern")
; TP = ?.
(length hash-1-0-0-1-0)
; TP + FP = ?.
(length targets-1-0-0-1-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-0-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 0 0 1 0) hash.txt"))
#| Comments - ?. |#

#| Step 18 - Run SIA on projection (1 1* 0 1 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-1*-0-1-0
  12
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 1@ 0 1 0) SIA")
  196878))
; ? seconds.

#| Step 19 - Run SIACT on projection (1 1* 0 1 0). |#
(progn
  (setq
   SIA-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1@ 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-1-0 dataset-1-1*-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1@ 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; ? seconds.
(length SIA-1-1*-0-1-0)
; size of SIA-output is ?.

#| Step 20 - Results for projection (1 1* 0 1 0). |#
(progn
  (setq
   SIACT-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1@ 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-1-0 dataset-1-1*-0-1-0))))
; ? seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-1*-0-1-0 hash-1-1*-0-1-0 12 "pattern")
; TP = ?.
(length hash-1-1*-0-1-0)
; TP + FP = ?.
(length targets-1-1*-0-1-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-1*-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 1@ 0 1 0) hash.txt"))
#| Comments - All targets discovered. |#

#| Step 21 - Run SIA on projection (1 0 1* 1 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-0-1*-1-0
  7
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 0 1@ 1 0) SIA")
  196878))
; ? seconds.

#| Step 22 - Run SIACT on projection (1 0 1* 1 0). |#
(progn
  (setq
   SIA-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1@ 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-1-0 dataset-1-0-1*-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1@ 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; ? seconds.
(length SIA-1-1*-0-1-0)
; size of SIA-output is ?.

#| Step 23 - Results for projection (1 0 1* 1 0). |#
(progn
  (setq
   SIACT-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1@ 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1*-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1*-1-0 dataset-1-0-1*-1-0))))
; ? seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-0-1*-1-0 hash-1-0-1*-1-0 7 "pattern")
; TP = ?.
(length hash-1-0-1*-1-0)
; TP + FP = ?.
(length targets-1-0-1*-1-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-0-1*-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 0 1@ 1 0) hash.txt"))
#| Comments - ?. |#

#| Step 24 - Run SIA on projection (1 1* 0 0 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-1*-0-0-0
  12
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 1@ 0 0 0) SIA")
  196878))
; ? seconds.

#| Step 25 - Run SIACT on projection (1 1* 0 0 0). |#
(progn
  (setq
   SIA-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1@ 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-0-0 dataset-1-1*-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1@ 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 7.131204 seconds.
(length SIA-1-1*-0-0-0)
; size of SIA-output is ?.

#| Step 26 - Results for projection (1 1* 0 0 0). |#
(progn
  (setq
   SIACT-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 1@ 0 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-0-0 dataset-1-1*-0-0-0))))
; ? seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-1*-0-0-0 hash-1-1*-0-0-0 12 "pattern")
; TP = ?.
(length hash-1-1*-0-0-0)
; TP + FP = ?.
(length targets-1-1*-0-0-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-1*-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 1@ 0 0 0) hash.txt"))
#| Comments - ?. |#

#| Step 27 - Run SIA on projection (1 0 1* 0 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-0-1*-0-0
  7
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 2 (1 0 1@ 0 0) SIA")
  196878))
; ? seconds.

#| Step 28 - Run SIACT on projection (1 0 1* 0 0). |#
(progn
  (setq
   SIA-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1@ 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-0-0 dataset-1-0-1*-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1@ 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; ? seconds.
(length SIA-1-1*-0-0-0)
; size of SIA-output is ?.

#| Step 29 - Results for projection (1 0 1* 0 0). |#
(progn
  (setq
   SIACT-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 2 (1 0 1@ 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1*-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1*-0-0 dataset-1-0-1*-0-0))))
; ? seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-0-1*-0-0 hash-1-0-1*-0-0 7 "pattern")
; TP = ?.
(length hash-1-0-1*-0-0)
; TP + FP = ?.
(length targets-1-0-1*-0-0)
; TP + TN = ?.

(write-to-file-balanced-hash-table
 hash-1-0-1*-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 2 (1 0 1@ 0 0) hash.txt"))
#| Comments - ?. |#

