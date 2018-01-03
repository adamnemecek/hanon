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
   dataset-1-1*-0-0-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-0-0 12 1)))
  (identity "Yes!"))
(progn
  (setq
   dataset-bot
   (orthogonal-projection-not-unique-equalp
    (restrict-dataset-in-nth-to-xs
     dataset 4 '(1)) '(1 1 1 1 0)))
  (setq
   dataset-1-1-0-1-bot
   (orthogonal-projection-unique-equalp
    dataset-bot '(1 1 0 1)))
  (setq
   dataset-1-1*-0-1-bot
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-1-bot 12 1)))
  (length dataset))
; size of full dataset is 628.

#| Step 3 - Run SIA on projection (1 1 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 1 0 1 0) SIA")
  196878))
; 911.179800 seconds.

#| Step 4 - Run SIACT on projection (1 1 0 1 0). |#
(progn
  (setq
   SIA-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-1-0 dataset-1-1-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 7.853982 seconds.
(length SIA-1-1-0-1-0)
; size of SIA-output is 112328.

#| Step 5 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L 1 analysis.lisp"))
(progn
  (setq
   SIACT-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-1-0 dataset-1-1-0-1-0))))
; 93.698920 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-1-0 hash-1-1-0-1-0 "pattern")
; TP = 2.
(length hash-1-1-0-1-0)
; TP + FP = 153.
(length targets-1-1-0-1-0)
; TP + TN = 3.

(write-to-file-balanced-hash-table
 hash-1-1-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 1 0 1 0) hash.txt"))
#| Comments - Pattern V was the issue here, with an
extra D6 in bar 51. |#

#| Step 6 - Run SIA on projection (1 0 1 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 0 1 1 0) SIA")
  196878))
; 817.850300 seconds.

#| Step 7 - Run SIACT on projection (1 0 1 1 0). |#
(progn
  (setq
   SIA-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-1-0 dataset-1-0-1-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 7.973269 seconds.
(length SIA-1-0-1-1-0)
; size of SIA-output is 102544.

#| Step 8 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   SIACT-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-1-0 dataset-1-0-1-1-0))))
; 92.313614 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-1-0 hash-1-0-1-1-0 "pattern")
; TP = 4.
(length hash-1-0-1-1-0)
; TP + FP = 148.
(length targets-1-0-1-1-0)
; TP + TN = 4.

(write-to-file-balanced-hash-table
 hash-1-0-1-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 0 1 1 0) hash.txt"))
#| Comments - All targets discovered. |#

#| Step 9 - Run SIA on projection (1 1 0 0 0). |#
(time
 (SIA-reflected
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 1 0 0 0) SIA")
  196878))
; 581.804000 seconds.

#| Step 10 - Run SIACT on projection (1 1 0 0 0). |#
(progn
  (setq
   SIA-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1-0-0-0 dataset-1-1-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 9.025578 seconds.
(length SIA-1-1-0-0-0)
; size of SIA-output is 60670.

#| Step 11 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   SIACT-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-1-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1-0-0-0 dataset-1-1-0-0-0))))
; 118.924750 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-0-0 hash-1-1-0-0-0 "pattern")
; TP = 4.
(length hash-1-1-0-0-0)
; TP + FP = 196.
(length targets-1-1-0-0-0)
; TP + TN = 6.

(write-to-file-balanced-hash-table
 hash-1-1-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 1 0 0 0) hash.txt"))
#| Comments - Pattern O is missing, as expected. |#

#| Step 12 - Run SIA on projection (1 0 1 0 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 0 1 0 0) SIA")
  196878))
; 518.878050 seconds.

#| Step 13 - Run SIACT on projection (1 0 1 0 0). |#
(progn
  (setq
   SIA-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-0-0 dataset-1-0-1-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 9.407164 seconds.
(length SIA-1-0-1-0-0)
; size of SIA-output is 49662.

#| Step 14 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   SIACT-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 1 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-0-0 dataset-1-0-1-0-0))))
; 136.874700 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-0-0 hash-1-0-1-0-0 "pattern")
; TP = 2.
(length hash-1-0-1-0-0)
; TP + FP = 222.
(length targets-1-0-1-0-0)
; TP + TN = 2.

(write-to-file-balanced-hash-table
 hash-1-0-1-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 0 1 0 0) hash.txt"))
#| Comments - All targets discovered. |#

#| Step 15 - Run SIA on projection (1 0 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 0 0 1 0) SIA")
  196878))
; 93.089035 seconds.

#| Step 16 - Run SIACT on projection (1 0 0 1 0). |#
(progn
  (setq
   SIA-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-0-1-0 dataset-1-0-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 4.049192 seconds.
(length SIA-1-0-0-1-0)
; size of SIA-output is 16871.

#| Step 17 - Results for projection (1 0 0 1 0). |#
(progn
  (setq
   SIACT-1-0-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 0 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-0-1-0 dataset-1-0-0-1-0))))
; 236.706790 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-0-1-0 hash-1-0-0-1-0 "pattern")
; TP = 1.
(length hash-1-0-0-1-0)
; TP + FP = 433.
(length targets-1-0-0-1-0)
; TP + TN = 3.

(write-to-file-balanced-hash-table
 hash-1-0-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 0 0 1 0) hash.txt"))
#| Comments - *compact-thresh* may be too lenient for
durations. |#

#| Step 18 - Run SIA on projection (1 1* 0 1 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-1*-0-1-0
  12
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 1@ 0 1 0) SIA")
  196878))
; 538.460750 seconds.

#| Step 19 - Run SIACT on projection (1 1* 0 1 0). |#
(progn
  (setq
   SIA-1-1*-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-1-0 dataset-1-1*-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 8.023277 seconds.
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
     "/L 1 (1 1@ 0 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-1-0 dataset-1-1*-0-1-0))))
; 191.692470 seconds seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-1*-0-1-0 hash-1-1*-0-1-0 12 "pattern")
; TP = 1.
(length hash-1-1*-0-1-0)
; TP + FP = 301.
(length targets-1-1*-0-1-0)
; TP + TN = 1.

(write-to-file-balanced-hash-table
 hash-1-1*-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 1@ 0 1 0) hash.txt"))
#| Comments - All targets discovered. |#

#| Step 21 - Run SIA on projection (1 1* 0 0 0). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-1*-0-0-0
  12
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 1@ 0 0 0) SIA")
  196878))
; 171.373400 seconds.

#| Step 22 - Run SIACT on projection (1 1* 0 0 0). |#
(progn
  (setq
   SIA-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-0-0 dataset-1-1*-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 0 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 7.131204 seconds.
(length SIA-1-1*-0-0-0)
; size of SIA-output is 18295.

#| Step 23 - Results for projection (1 1* 0 0 0). |#
(progn
  (setq
   SIACT-1-1*-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 0 0) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-0-0 dataset-1-1*-0-0-0))))
; 334.748000 seconds.

(number-of-targets-trans-mod-in-hash-tables
 targets-1-1*-0-0-0 hash-1-1*-0-0-0 12 "pattern")
; TP = 3.
(length hash-1-1*-0-0-0)
; TP + FP = 582.
(length targets-1-1*-0-0-0)
; TP + TN = 5.

(write-to-file-balanced-hash-table
 hash-1-1*-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 1@ 0 0 0) hash.txt"))
#| Comments - Pattern N is missing, as expected.
Pattern P has consequent notes that maintain a high
enough compactness to the first G's in bar 21. It's a
good example. |#

#| Step 24 - Run SIA on projection (1 1* 0 1 bot). |#
(time
 (SIA-reflected-mod-2nd-n
  dataset-1-1*-0-1-bot
  12
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/L 1 (1 1@ 0 1 bot) SIA")
  196878))
; 23.635320 seconds.

#| Step 25 - Run SIACT on projection
(1 1* 0 1 bot). |#
(progn
  (setq
   SIA-1-1*-0-1-bot
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 1 bot) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-1-bot dataset-1-1*-0-1-bot
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 1 bot) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 0.977264 seconds.
(length SIA-1-1*-0-1-bot)
; size of SIA-output is 14175.

#| Step 26 - Results for projection (1 1* 0 1 bot). |#
(progn
  (setq
   SIACT-1-1*-0-1-bot
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 1 bot) CT 1.txt")))
  (time
   (setq
    hash-1-1*-0-1-bot
    (evaluate-variables-of-patterns2hash
     SIACT-1-1*-0-1-bot dataset-1-1*-0-1-bot))))
; 30.146814 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1*-0-1-bot hash-1-1*-0-1-bot "pattern")
; TP = 1.
(length hash-1-1*-0-1-bot)
; TP + FP = 247.
(length targets-1-1*-0-1-bot)
; TP + TN = 1.

(write-to-file-balanced-hash-table
 hash-1-1*-0-1-bot
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files"
  "/L 1 (1 1@ 0 1 bot) hash.txt"))
#| Comments - ?. |#

