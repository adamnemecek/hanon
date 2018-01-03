
(progn
  (setq
   hash-1-1*-0-0-0
   (read-from-file-balanced-hash-table
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1@ 0 0 0) hash.txt")))
  (identity "yes"))

(progn
  (setq
   Mposs
   (gethash '"pattern" (nth 0 hash-1-1*-0-0-0)))
  (identity "Cheddar"))

(index-two-lists-1st-not-equalp M Mposs)

(index-target-translation-mod-in-hash-tables
 M hash-1-1*-0-0-0 12 "pattern")

(index-target-translation-mod-in-hash-tables
 E hash-1-1*-0-0-0 12 "pattern")

(gethash '"pattern" (nth 2 hash-1-1*-0-0-0))
; E without the downbeat.

(setq
 pat1
 (gethash '"pattern" (nth 1 hash-1-1*-0-0-0)))
(setq
 pat3
 (gethash '"pattern" (nth 3 hash-1-1*-0-0-0)))
(setq
 pat3trans
 (translation-mod-2nd-n pat3 '(-148 7) 12))

(index-target-translation-mod-in-hash-tables
 D hash-1-1*-0-0-0 12 "pattern")


