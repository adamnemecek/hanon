#| Tom Collins
   Tuesday 4 May 2010
   Incomplete |#

#| The purpose is to apply the discovery algorithm
to Bach's Prelude in E Major, BWV 854. |#

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
  "/Bach preludes/BWV 854.lisp"))
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
; size of full dataset is 425.

#| Step 3 - Run SIA on projection (1 1 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 1 0 1 0) SIA")
  90100))
; 238.045360 seconds.

#| Step 4 - Run SIACT on projection (1 1 0 1 0). |#
(progn
  (setq
   SIA-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-1-0 dataset-1-1-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 3.390696 seconds.
(length SIA-1-1-0-1-0)
; size of SIA-output is 50455.

#| Step 5 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/BWV 854 analysis.lisp"))
(progn
  (setq
   SIACT-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-1-0 dataset-1-1-0-1-0))))
; 32.525654 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-1-0 hash-1-1-0-1-0 "pattern")
; TP = 2.
(length hash-1-1-0-1-0)
; TP + FP = 172.
(length targets-1-1-0-1-0)
; TP + TN = 2.

(write-to-file-balanced-hash-table
 hash-1-1-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/BWV 854 (1 1 0 1 0) hash.txt"))
#| Comments - All targets discovered. |#

#| Step 6 - Run SIA on projection (1 0 1 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 0 1 1 0) SIA")
  90100))
; 211.628140 seconds.

#| Step 7 - Run SIACT on projection (1 0 1 1 0). |#
(progn
  (setq
   SIA-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-1-0 dataset-1-0-1-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 3.589698 seconds.
(length SIA-1-0-1-1-0)
; size of SIA-output is 43761.

#| Step 8 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   SIACT-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-1-0 dataset-1-0-1-1-0))))
; 44.987373 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-1-0 hash-1-0-1-1-0 "pattern")
; TP = 5.
(length hash-1-0-1-1-0)
; TP + FP = 213.
(length targets-1-0-1-1-0)
; TP + TN = 11.

(write-to-file-balanced-hash-table
 hash-1-0-1-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/BWV 854 (1 0 1 1 0) hash.txt"))
#| Comments - Haven't looked to see what is and is
not discovered yet. |#

#| Step 9 - Run SIA on projection (1 1 0 0 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 1 0 0 0) SIA")
  90100))
; 94.434020 seconds.

#| Step 10 - Run SIACT on projection (1 1 0 0 0). |#
(progn
  (setq
   SIA-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-0-0 dataset-1-1-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 3.999035 seconds.
(length SIA-1-1-0-0-0)
; size of SIA-output is 19036.

#| Step 11 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   SIACT-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1 0 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-0-0 dataset-1-1-0-0-0))))
; 64.061160 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-0-0 hash-1-1-0-0-0 "pattern")
; TP = 1.
(length hash-1-1-0-0-0)
; TP + FP = 318.
(length targets-1-1-0-0-0)
; TP + TN = 4.

(write-to-file-balanced-hash-table
 hash-1-1-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/BWV 854 (1 1 0 0 0) hash.txt"))
#| Comments - Haven't looked to see what is and is
not discovered yet. |#

#| Step 12 - Run SIA on projection (1 0 1 0 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 0 1 0 0) SIA")
  90100))
; 68.771650 seconds.

#| Step 13 - Run SIACT on projection (1 0 1 0 0). |#
(progn
  (setq
   SIA-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-0-0 dataset-1-0-1-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 4.907202 seconds.
(length SIA-1-0-1-0-0)
; size of SIA-output is 12967.

#| Step 14 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   SIACT-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-0-0 dataset-1-0-1-0-0))))
; 88.706680 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-0-0 hash-1-0-1-0-0 "pattern")
; TP = 9.
(length hash-1-0-1-0-0)
; TP + FP = 419.
(length targets-1-0-1-0-0)
; TP + TN = 10.

(write-to-file-balanced-hash-table
 hash-1-0-1-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/BWV 854 (1 0 1 0 0) hash.txt"))
#| Comments - Haven't looked to see what is and is
not discovered yet. |#

#| Step 15 - Run SIA on projection (1 0 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 0 0 1 0) SIA")
  90100))
; 38.567280 seconds.

#| Step 16 - Run SIACT on projection (1 0 0 1 0). |#
(progn
  (setq
   SIA-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-0-1-0 dataset-1-0-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 2.220250 seconds.
(length SIA-1-0-0-1-0)
; size of SIA-output is 8525.

#| Step 17 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   SIACT-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-0-1-0 dataset-1-0-0-1-0))))
; 387.947720 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-0-1-0 hash-1-0-0-1-0 "pattern")
; TP = 0.
(length hash-1-0-0-1-0)
; TP + FP = 627.
(length targets-1-0-0-1-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-0-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/BWV 854 (1 0 0 1 0) hash.txt"))
#| Comments - Haven't looked to see what is and is
not discovered yet. |#

#| Step 18 - Run SIA on projection (1 1* 0 1 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-1*-0-1-0
  12
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 1@ 0 1 0) SIA")
  90100))
; 155.590380 seconds.

#| Step 19 - Run SIACT on projection (1 1* 0 1 0). |#
(progn
  (setq
   SIA-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1@ 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-1-0 dataset-1-1*-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1@ 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 4.125103 seconds.
(length SIA-1-1*-0-1-0)
; size of SIA-output is 31071.

#| Step 20 - Results for projection (1 1* 0 1 0). |#
(progn
  (setq
   SIACT-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1@ 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-1-0 dataset-1-1*-0-1-0))))
; 72.102370 seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-1*-0-1-0 hash-1-1*-0-1-0 12 "pattern")
; TP = 0.
(length hash-1-1*-0-1-0)
; TP + FP = 388.
(length targets-1-1*-0-1-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-1*-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/BWV 854 (1 1@ 0 1 0) hash.txt"))
#| Comments - Haven't looked to see what is and is
not discovered yet. |#

#| Step 21 - Run SIA on projection (1 0 1* 1 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-0-1*-1-0
  7
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 0 1@ 1 0) SIA")
  90100))
; 129.538220 seconds.

#| Step 22 - Run SIACT on projection (1 0 1* 1 0). |#
(progn
  (setq
   SIA-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1@ 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-1-0 dataset-1-0-1*-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1@ 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 4.665849 seconds.
(length SIA-1-1*-0-1-0)
; size of SIA-output is 31071.

#| Step 23 - Results for projection (1 0 1* 1 0). |#
(progn
  (setq
   SIACT-1-0-1*-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1@ 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1*-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1*-1-0 dataset-1-0-1*-1-0))))
; 117.914100 seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-0-1*-1-0 hash-1-0-1*-1-0 7 "pattern")
; TP = 0.
(length hash-1-0-1*-1-0)
; TP + FP = 578.
(length targets-1-0-1*-1-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-0-1*-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/BWV 854 (1 0 1@ 1 0) hash.txt"))
#| Comments - Haven't looked to see what is and is
not discovered yet. |#

#| Step 24 - Run SIA on projection (1 1* 0 0 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-1*-0-0-0
  12
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 854 (1 1@ 0 0 0) SIA")
  90100))
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
     "/BWV 854 (1 1@ 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-0-0 dataset-1-1*-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 1@ 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; ? seconds.
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
     "/BWV 854 (1 1@ 0 0 0) CT 1.txt")))
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
  "/SIACT/Write to files/BWV 854 (1 1@ 0 0 0) hash.txt"))
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
   "/BWV 854 (1 0 1@ 0 0) SIA")
  90100))
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
     "/BWV 854 (1 0 1@ 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-0-0 dataset-1-0-1*-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 854 (1 0 1@ 0 0) CT 1.txt")
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
     "/BWV 854 (1 0 1@ 0 0) CT 1.txt")))
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
  "/SIACT/Write to files/BWV 854 (1 0 1@ 0 0) hash.txt"))
#| Comments - ?. |#

