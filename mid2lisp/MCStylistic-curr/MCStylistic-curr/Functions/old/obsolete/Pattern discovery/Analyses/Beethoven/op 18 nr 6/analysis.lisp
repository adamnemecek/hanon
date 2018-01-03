#| Tom Collins
   Tuesday 4 May 2010
   Incomplete |#

#| The purpose is to apply SIACT to Beethoven's
String Quartet in Bb Major, op 18 nr 6, 2nd mvt,
bars 1-8. |#

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
(setq *compact-thresh* 1/2)
(setq *cardina-thresh* 2)

#| Step 2 - Set pathnames. |#
(setq
 *datapath*
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Datasets/Beethoven/op 18 nr 6/dataset.lisp"))
(setq
 *write2path*
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Analyses/Beethoven/op 18 nr 6/Write to files"))

#| Step 3 - Create dataset. |#
(load *datapath*)
(progn
  (setq
   dataset-1-0-1-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 0 1 1 0)))
  (identity "Yes!"))
#|
(progn
  (setq
   dataset-1-1*-0-1-0
   (sort-dataset-asc
    (mod-column
     dataset-1-1-0-1-0 12 1)))
  (identity "Yes!"))
|#
; size of full dataset is 181.

#| Step 4 - Run SIA on projection (1 0 1 1 0). |#
(time
 (SIA-reflected
  dataset-1-0-1-1-0
  (concatenate
   'string *write2path* "/(1 0 1 1 0) SIA") 16290))
; 6.671923 seconds.

#| Step 5 - Run SIACT on projection (1 0 1 1 0). |#
(progn
  (setq
   SIA-1-0-1-1-0
   (read-from-file
    (concatenate
     'string *write2path* "/(1 0 1 1 0) SIA 1.txt")))
  (time
   (compactness-trawler
    SIA-1-0-1-1-0 dataset-1-0-1-1-0
    (concatenate
     'string
     *write2path* "/(1 0 1 1 0) CT 1.txt")
    *compact-thresh* *cardina-thresh*)))
; 0.228496 seconds.
(length SIA-1-0-1-1-0)
; size of SIA-output is 10154.

#| Step 6 - Results for projection (1 0 1 1 0). |#
(progn
  (setq
   SIACT-1-0-1-1-0
   (read-from-file
    (concatenate
     'string *write2path* "/(1 0 1 1 0) CT 1.txt")))
  (time
   (setq
    hash-1-0-1-1-0
    (evaluate-variables-of-patterns2hash
     SIACT-1-0-1-1-0 dataset-1-0-1-1-0))))
; 2.735051 seconds.

(length hash-1-0-1-1-0)
; TP + FP = 119.

(write-to-file-balanced-hash-table
 hash-1-0-1-1-0
 (concatenate
  'string *write2path* "/(1 0 1 1 0) hash.txt"))
#| Comments - . |#

