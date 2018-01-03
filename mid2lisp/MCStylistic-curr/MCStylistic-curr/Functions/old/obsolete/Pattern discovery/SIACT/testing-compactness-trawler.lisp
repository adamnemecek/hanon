
; REQUIRED PACKAGES:
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/compactness-trawler/new.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Pattern discovery"
  "/Scarlatti sonatas/L 1.lisp"))

(progn
  (setq
   SIA-output
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/compactness-trawler/Write to files"
     "/L 1 (1 1 0 1 0) SIA 1.txt")))
  (setq
   dataset-1-1-0-1-0
   (orthogonal-projection-unique-equalp
    dataset '(1 1 0 1 0)))
  (setq
   path&name
   (concatenate
    'string
    "/Applications/CCL/Lisp code/Pattern discovery"
    "/compactness-trawler/Write to files"
    "/L 1 (1 1 0 1 0) CT 1.txt")))

(time
 (compactness-trawler
  SIA-output dataset-1-1-0-1-0 path&name 2/3 5))


(progn
  (setq SIA-small (subseq SIA-output 0 71162))
  (identity "SIA-small"))
(time
 (compactness-trawler
  SIA-small dataset-1-1-0-1-0 path&name 2/3 5))
; 13.562 seconds

(progn
  (setq
   growing-list
   (read-from-file
    (concatenate
     'string
     "/Applications/CCL/Lisp code/Pattern discovery"
     "/SIACT/Write to files"
     "/L 1 (1 1 0 1 0) CT 1.txt")))
  (identity "growing-list read"))

#| Some extra tests made on 29 July 2010 to check
suspicions about some problems with the compactness
trawler. |#

(setq
 dataset
 '((1 1) (1 3) (2 2) (2 3) (3 1) (3 2) (3 3) (4 3)))
(setq
 pattern
 '((1 1) (1 3) (2 3) (4 3)))
(setq compactness-threshold 2/3)
(setq cardinality-threshold 4)
(setq region-type "lexicographic")

(setq result nil)
(setq catch (list (first pattern)))
(setq catch-compactness
         (if (my-last catch) ;?
           (compactness
            catch dataset region-type)))

(setq catch (append catch (list (second pattern))))
(setq pattern (rest pattern))

(setq result (append result (list (butlast catch))))
