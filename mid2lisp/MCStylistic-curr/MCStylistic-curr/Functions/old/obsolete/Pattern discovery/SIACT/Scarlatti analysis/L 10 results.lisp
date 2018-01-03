#| Tom Collins
   Friday 12 February January 2010
   Incomplete |#

#| The purpose is to apply the pattern discovery
algorithm to Scarlatti's Sonata in C Minor, L. 10
(K. 84). |#

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
(setq *cardina-thresh* 3)

#| Step 2 - Create datasets. |#
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

#| Step 3 - Run SIA on projection (1 1 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 10 (1 1 0 1 0) SIA")
  379756))
; 2993.744 seconds.

#| Step 4 - Run SIACT on projection (1 1 0 1 0). |#
(progn
  (setq
   SIA-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-1-0 dataset-1-1-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 31.399769 seconds.
(length SIA-1-1-0-1-0)
; size of SIA-output is 133897.

#| Step 5 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L 10 analysis.lisp"))
(progn
  (setq
   SIACT-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-1-0 dataset-1-1-0-1-0))))
; 836.918900 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-1-0 hash-1-1-0-1-0 "pattern")
; TP = 4.
(length hash-1-1-0-1-0)
; TP + FP = 499.
(length targets-1-1-0-1-0)
; TP + TN = 4.

(write-to-file-balanced-hash-table
 hash-1-1-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 1 0 1 0) hash.txt"))
#| Comments - ?. |#

#| Step 6 - Run SIA on projection (1 0 1 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 10 (1 0 1 1 0) SIA")
  379756))
; 2543.516400 seconds.

#| Step 7 - Run SIACT on projection (1 0 1 1 0). |#
(progn
  (setq
   SIA-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-1-0 dataset-1-0-1-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 35.473785 seconds.
(length SIA-1-0-1-1-0)
; size of SIA-output is 102316.

#| Step 8 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   SIACT-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-1-0 dataset-1-0-1-1-0))))
; 779.912230 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-1-0 hash-1-0-1-1-0 "pattern")
; TP = 2.
(length hash-1-0-1-1-0)
; TP + FP = 440.
(length targets-1-0-1-1-0)
; TP + TN = 7.

(write-to-file-balanced-hash-table
 hash-1-0-1-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 0 1 1 0) hash.txt"))
#| Comments - ?. |#

#| Step 9 - Run SIA on projection (1 1 0 0 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 10 (1 1 0 0 0) SIA")
  379756))
; 1384.710900 seconds.

#| Step 10 - Run SIACT on projection (1 1 0 0 0). |#
(progn
  (setq
   SIA-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-0-0 dataset-1-1-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 35.948486 seconds.
(length SIA-1-1-0-0-0)
; size of SIA-output is 51510.

#| Step 11 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   SIACT-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1 0 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-0-0 dataset-1-1-0-0-0))))
; 1112.427600 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-0-0 hash-1-1-0-0-0 "pattern")
; TP = 3.
(length hash-1-1-0-0-0)
; TP + FP = 651.
(length targets-1-1-0-0-0)
; TP + TN = 3.

(write-to-file-balanced-hash-table
 hash-1-1-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 1 0 0 0) hash.txt"))
#| Comments - ?. |#

#| Step 12 - Run SIA on projection (1 0 1 0 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 10 (1 0 1 0 0) SIA")
  379756))
; 909.317000 seconds.

#| Step 13 - Run SIACT on projection (1 0 1 0 0). |#
(progn
  (setq
   SIA-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-0-0 dataset-1-0-1-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 43.664394 seconds.
(length SIA-1-0-1-0-0)
; size of SIA-output is 34398.

#| Step 14 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   SIACT-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-0-0 dataset-1-0-1-0-0))))
; 1142.852000 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-0-0 hash-1-0-1-0-0 "pattern")
; TP = 5.
(length hash-1-0-1-0-0)
; TP + FP = 629.
(length targets-1-0-1-0-0)
; TP + TN = 8.

(write-to-file-balanced-hash-table
 hash-1-0-1-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 0 1 0 0) hash.txt"))
#| Comments - ?. |#

#| Step 15 - Run SIA on projection (1 0 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 10 (1 0 0 1 0) SIA")
  379756))
; 90.626640 seconds.

#| Step 16 - Run SIACT on projection (1 0 0 1 0). |#
(progn
  (setq
   SIA-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-0-1-0 dataset-1-0-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 24.748500 seconds.
(length SIA-1-0-0-1-0)
; size of SIA-output is 6639.

#| Step 17 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   SIACT-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-0-1-0 dataset-1-0-0-1-0))))
; 3898.388400 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-0-1-0 hash-1-0-0-1-0 "pattern")
; TP = 0.
(length hash-1-0-0-1-0)
; TP + FP = 1347.
(length targets-1-0-0-1-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-0-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 0 0 1 0) hash.txt"))
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
   "/L 10 (1 1@ 0 1 0) SIA")
  379756))
; 1373.461400 seconds.

#| Step 19 - Run SIACT on projection (1 1* 0 1 0). |#
(progn
  (setq
   SIA-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1@ 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-1-0 dataset-1-1*-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1@ 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 38.438812 seconds.
(length SIA-1-1*-0-1-0)
; size of SIA-output is 58834.

#| Step 20 - Results for projection (1 1* 0 1 0). |#
(progn
  (setq
   SIACT-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1@ 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-1-0 dataset-1-1*-0-1-0))))
; 1496.327900 seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-1*-0-1-0 hash-1-1*-0-1-0 12 "pattern")
; TP = 0.
(length hash-1-1*-0-1-0)
; TP + FP = 978.
(length targets-1-1*-0-1-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-1*-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 1@ 0 1 0) hash.txt"))
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
   "/L 10 (1 0 1@ 1 0) SIA")
  379756))
; 896.441900 seconds.

#| Step 22 - Run SIACT on projection (1 0 1* 1 0). |#
(progn
  (setq
   SIA-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-1-0 dataset-1-0-1*-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 45.985893 seconds.
(length SIA-1-0-1*-1-0)
; size of SIA-output is 33746.

#| Step 23 - Results for projection (1 0 1* 1 0). |#
(progn
  (setq
   SIACT-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1*-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1*-1-0 dataset-1-0-1*-1-0))))
; 2091.657700 seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-0-1*-1-0 hash-1-0-1*-1-0 7 "pattern")
; TP = 0.
(length hash-1-0-1*-1-0)
; TP + FP = 1288.
(length targets-1-0-1*-1-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-0-1*-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 0 1@ 1 0) hash.txt"))
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
   "/L 10 (1 1@ 0 0 0) SIA")
  379756))
; 271.903140 seconds.

#| Step 25 - Run SIACT on projection (1 1* 0 0 0). |#
(progn
  (setq
   SIA-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1@ 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-0-0 dataset-1-1*-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1@ 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 44.543873 seconds.
(length SIA-1-1*-0-0-0)
; size of SIA-output is 11858.

#| Step 26 - Results for projection (1 1* 0 0 0). |#
(progn
  (setq
   SIACT-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 1@ 0 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-0-0 dataset-1-1*-0-0-0))))
; 2502.814000 seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-1*-0-0-0 hash-1-1*-0-0-0 12 "pattern")
; TP = 0.
(length hash-1-1*-0-0-0)
; TP + FP = 1637.
(length targets-1-1*-0-0-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-1*-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 1@ 0 0 0) hash.txt"))
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
   "/L 10 (1 0 1@ 0 0) SIA")
  379756))
; 177.554280 seconds.

#| Step 28 - Run SIACT on projection (1 0 1* 0 0). |#
(progn
  (setq
   SIA-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-0-0 dataset-1-0-1*-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 60.939724 seconds.
(length SIA-1-1*-0-0-0)
; size of SIA-output is 7818.

#| Step 29 - Results for projection (1 0 1* 0 0). |#
(progn
  (setq
   SIACT-1-0-1*-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 10 (1 0 1@ 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1*-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1*-0-0 dataset-1-0-1*-0-0))))
; 5258.151400 seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-0-1*-0-0 hash-1-0-1*-0-0 7 "pattern")
; TP = 1.
(length hash-1-0-1*-0-0)
; TP + FP = 2727.
(length targets-1-0-1*-0-0)
; TP + TN = 1.

(write-to-file-balanced-hash-table
 hash-1-0-1*-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 10 (1 0 1@ 0 0) hash.txt"))
#| Comments - ?. |#

