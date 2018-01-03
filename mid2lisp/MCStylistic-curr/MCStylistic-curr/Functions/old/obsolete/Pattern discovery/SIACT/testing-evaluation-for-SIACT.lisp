#| Tom Collins
   Tuesday 19 January 2010
   Incomplete

Test rating the trawled patterns. |#

; REQUIRED PACKAGES
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))
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
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/evaluation-for-SIACT.lisp"))

(progn
  (setq
   SIACT-output
   (subseq
    (read-from-file
     (concatenate
      'string
      "/Applications/CCL/Lisp code/Pattern discovery"
      "/SIACT/Write to files"
      "/L 1 (1 1 0 1 0) CT 1.txt"))
    0 153))
  (load
   (concatenate
    'string
    "//Applications/CCL/Lisp code/Pattern discovery"
    "/Scarlatti sonatas/L 1.lisp"))
  (setq
   dataset-1-1-0-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 1 0)))
  (identity "reading done"))

(time
 (progn
   (setq
    patterns-hash
    (evaluate-variables-of-patterns2hash
     SIACT-output dataset-1-1-0-1-0))
   (identity "results are in!")))
; 49.662 seconds.

(gethash '"index" (first patterns-hash))
(gethash '"rating" (first patterns-hash))
(gethash '"pattern" (first patterns-hash))
(gethash '"occurrences" (first patterns-hash))
(gethash '"translators" (first patterns-hash))

(gethash '"index" (nth 8 patterns-hash))
(gethash '"rating" (nth 8 patterns-hash))
(gethash '"pattern" (nth 8 patterns-hash))
(gethash '"occurrences" (nth 8 patterns-hash))
(gethash '"translators" (nth 8 patterns-hash))

(write-to-file-balanced-hash-table
 patterns-hash
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Write to files/L 1 (1 1 0 1 0) hash.txt"))

(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/SIACT/Scarlatti analysis/L 1 analysis.lisp"))

(number-of-targets-translation-in-hash-tables
 targets-1-1-0-1-0 patterns-hash "pattern")

(test-target-translation-in-hash-tables
 (nth 0 targets-1-1-0-1-0) patterns-hash "pattern")

