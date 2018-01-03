#| Tom Collins
   Sunday 5 September 2010
   Incomplete |#

#| The purpose is to apply the pattern discovery
algorithm SIACT<-> to Bach's Prelude No. 4 in C#
Minor BWV849. |#

; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
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
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/trawl-different-ways.lisp"))

#| Step 1 - Set parameters. |#
(setq *compact-thresh* 2/3)
(setq *cardina-thresh* 5)

#| Step 2 - Create datasets. |#
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

#| Step 3 - Run SIA on projection (1 1 0 1 0). This
has already been done. |#
(time
 (SIA-reflected
  dataset-1-1-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 849 (1 1 0 1 0) SIA")
  221445))
; 1397.608400 seconds.

#| Step 4 - Run SIACT<-> on projection (1 1 0 1 0). |#
(progn
  (setq
   SIA-1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler<->
    SIA-1-1-0-1-0 dataset-1-1-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1 0 1 0) CT<-> 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 11.263772 seconds.
(length SIA-1-1-0-1-0)
; size of SIA-output is 117782.

#| Step 5 - Results for projection (1 1 0 1 0). |#
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/BWV 849 analysis.lisp"))
(progn
  (setq
   SIACT<->1-1-0-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1 0 1 0) CT<-> 1.txt")))
  (time
   (setq
    hash-1-1-0-1-0
    (evaluate-variables-of-patterns2hash
     SIACT<->1-1-0-1-0 dataset-1-1-0-1-0))))
; 53.734623 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-1-0 hash-1-1-0-1-0 "pattern")
; TP = 1.
(length hash-1-1-0-1-0)
; TP + FP = 66.
(length targets-1-1-0-1-0)
; TP + TN = 2.

(write-to-file-balanced-hash-table
 hash-1-1-0-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files"
  "/BWV 849 (1 1 0 1 0) hash<->.txt"))
#| Comments - ?. |#

#| Step 6 - Run SIA on projection (1 0 1 1 0). This
has already been done. |#
(time
 (SIA-reflected
  dataset-1-0-1-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 849 (1 0 1 1 0) SIA")
  221445))
; 1207.279000 seconds.

#| Step 7 - Run SIACT<-> on projection (1 0 1 1 0). |#
(progn
  (setq
   SIA-1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1 1 0) SIA 1.txt")))
  (time
   (compactness-trawler<->
    SIA-1-0-1-1-0 dataset-1-0-1-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1 1 0) CT<-> 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 12.157177 seconds.
(length SIA-1-0-1-1-0)
; size of SIA-output is 99400.

#| Step 8 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   SIACT<->1-0-1-1-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1 1 0) CT<-> 1.txt")))
  (time
   (setq
    hash-1-0-1-1-0
    (evaluate-variables-of-patterns2hash
     SIACT<->1-0-1-1-0 dataset-1-0-1-1-0))))
; 78.311820 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-1-0 hash-1-0-1-1-0 "pattern")
; TP = 3.
(length hash-1-0-1-1-0)
; TP + FP = 81.
(length targets-1-0-1-1-0)
; TP + TN = 8.

(write-to-file-balanced-hash-table
 hash-1-0-1-1-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files"
  "/BWV 849 (1 0 1 1 0) hash<->.txt"))
#| Comments - ?. |#

#| Step 9 - Run SIA on projection (1 1 0 0 0). This
has already been done. |#
(time
 (SIA-reflected
  dataset-1-1-0-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 849 (1 1 0 0 0) SIA")
  221445))
; 381.319920 seconds.

#| Step 10 - Run SIACT<-> on projection
(1 1 0 0 0). |#
(progn
  (setq
   SIA-1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler<->
    SIA-1-1-0-0-0 dataset-1-1-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1 0 0 0) CT<-> 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 13.584494 seconds.
(length SIA-1-1-0-0-0)
; size of SIA-output is 29118.

#| Step 11 - Results for projection (1 1 0 0 0). |#
(progn
  (setq
   SIACT<->1-1-0-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1 0 0 0) CT<-> 1.txt")))
  (time
   (setq
    hash-1-1-0-0-0
    (evaluate-variables-of-patterns2hash
     SIACT<->1-1-0-0-0 dataset-1-1-0-0-0))))
; 120.438290 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-0-0 hash-1-1-0-0-0 "pattern")
; TP = 0.
(length hash-1-1-0-0-0)
; TP + FP = 149.
(length targets-1-1-0-0-0)
; TP + TN = 0.

(write-to-file-balanced-hash-table
 hash-1-1-0-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files"
  "/BWV 849 (1 1 0 0 0) hash<->.txt"))
#| Comments - ?. |#

#| Step 12 - Run SIA on projection (1 0 1 0 0). This
has already been done. |#
(time
 (SIA-reflected
  dataset-1-0-1-0-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 849 (1 0 1 0 0) SIA")
  221445))
; ? seconds.

#| Step 13 - Run SIACT<-> on projection
(1 0 1 0 0). |#
(progn
  (setq
   SIA-1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1 0 0) SIA 1.txt")))
  (time
   (compactness-trawler<->
    SIA-1-0-1-0-0 dataset-1-0-1-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1 0 0) CT<-> 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 13.553752 seconds.
(length SIA-1-0-1-0-0)
; size of SIA-output is 18410.

#| Step 14 - Results for projection (1 0 1 0 0). |#
(progn
  (setq
   SIACT<->1-0-1-0-0
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1 0 0) CT<-> 1.txt")))
  (time
   (setq
    hash-1-0-1-0-0
    (evaluate-variables-of-patterns2hash
     SIACT<->1-0-1-0-0 dataset-1-0-1-0-0))))
; 211.533660 seconds.

(number-of-targets-translation-in-hash-tables
 targets-1-0-1-0-0 hash-1-0-1-0-0 "pattern")
; TP = 4.
(length hash-1-0-1-0-0)
; TP + FP = 236.
(length targets-1-0-1-0-0)
; TP + TN = 8.

(write-to-file-balanced-hash-table
 hash-1-0-1-0-0
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files"
  "/BWV 849 (1 0 1 0 0) hash<->.txt"))
#| Comments - Got up to here. |#

#| Step 15 - Run SIA on projection (1 0 0 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-0-1-0
  (concatenate
   'string
   "//Applications/CCL/Lisp code"
   "/Pattern discovery/SIACT/Write to files"
   "/BWV 849 (1 0 0 1 0) SIA")
  221445))
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
     "/BWV 849 (1 0 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-0-1-0 dataset-1-0-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 0 1 0) CT 1.txt")
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
     "/BWV 849 (1 0 0 1 0) CT 1.txt")))
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
  "/SIACT/Write to files"
  "/BWV 849 (1 0 0 1 0) hash.txt"))
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
   "/BWV 849 (1 1@ 0 1 0) SIA")
  221445))
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
     "/BWV 849 (1 1@ 0 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-1-0 dataset-1-1*-0-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1@ 0 1 0) CT 1.txt")
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
     "/BWV 849 (1 1@ 0 1 0) CT 1.txt")))
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
  "/SIACT/Write to files"
  "/BWV 849 (1 1@ 0 1 0) hash.txt"))
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
   "/BWV 849 (1 0 1@ 1 0) SIA")
  221445))
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
     "/BWV 849 (1 0 1@ 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-1-0 dataset-1-0-1*-1-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1@ 1 0) CT 1.txt")
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
     "/BWV 849 (1 0 1@ 1 0) CT 1.txt")))
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
  "/SIACT/Write to files"
  "/BWV 849 (1 0 1@ 1 0) hash.txt"))
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
   "/BWV 849 (1 1@ 0 0 0) SIA")
  221445))
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
     "/BWV 849 (1 1@ 0 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-1*-0-0-0 dataset-1-1*-0-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 1@ 0 0 0) CT 1.txt")
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
     "/BWV 849 (1 1@ 0 0 0) CT 1.txt")))
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
  "/SIACT/Write to files"
  "/BWV 849 (1 1@ 0 0 0) hash.txt"))
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
   "/BWV 849 (1 0 1@ 0 0) SIA")
  221445))
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
     "/BWV 849 (1 0 1@ 0 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1*-0-0 dataset-1-0-1*-0-0
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/BWV 849 (1 0 1@ 0 0) CT 1.txt")
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
     "/BWV 849 (1 0 1@ 0 0) CT 1.txt")))
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
  "/SIACT/Write to files"
  "/BWV 849 (1 0 1@ 0 0) hash.txt"))
#| Comments - ?. |#

